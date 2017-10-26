// simple kaleidoscope-style presentation
// of GPS data points

// garrison lemasters
// cct georgetown 2017

// be sure to grab the dayinthelife.csv file
// and put it in your /data directory.

float[][] latLong;
float minLat, minLon, maxLat, maxLon;
float xMin, xMax, yMin, yMax;
int recordID;


// note that this particular version of the code
// is ill-suited for dumping to a PDF or AI (or SVG)
// file -- the image is a collection of millions of
// points -- the resultant file would be very
// large and difficult to work with.
//
void setup() {
  size(800, 800, FX2D);
  smooth(8);
  recordID=0;

  // call custom functions from inside
  // setup() to make code a bit neater.

  dataParse();
  variableSetup();
  initScreen();
}


void draw() {
  // do a loop as long as we haven't reached the last record:
  // I compare the record number to the length of latLong[1] --
  // although I could've just as easily used latLong[0], since
  // both are the same length. 

  // But wait, you'll say:  Isn't latLong a 2-dimensional array?
  // What the hell is going on here?

  // First:  Calm down.
  // Second:  When I want to refer to the WHOLE array, and not
  // just a single element, I leave the brackets off.  If I:
  //   println(latLong[0]);
  // I'll get all 56,000 records from the 0th column.  Confusing?
  // Yup.  It makes more sense, perhaps, if you think about passing
  // a one-dimensional array to a custom function.  Say my array
  // studentID has 50 elements, because I have 50 students.
  // So studentID[0] is "09083323", and studentID[49] is "943422a".
  // If I want to send ALL of those records to a function
  // called "verifyStudents()", in one fell swoop, I just do this:
  //   verifyStudents(studentID);

  // A slower, less efficient way of doing a similar thing:
  /*
    for (int i=0; i<studentID.length; i++) {
   verifyStudents(studentID[i]);
   }
   */

  if (recordID < latLong.length) {

    // white lines, as long as we haven't
    // started mapping the second half of the coordinates --
    // in which case, we're probably headed home, so
    // we'll switch to red.

    if (recordID < (latLong.length*0.5)) {
      stroke(255);
      strokeWeight(2);
    } else {
      stroke(245, 40, 40);
      strokeWeight(1);
    }

    // every 350 chunks of data, we'll put a big yellow block
    // % is "modulo," as in "recordID modulo 350," which yields
    // the remainder.  If recordID is 320, then recordID%350
    // yields 320 (since it 350 doesn't go into 320 at least once).
    // If recordID = 350, then recordID%350 is 0:  350/350 is
    // 1, with no remainder.

    if (recordID%350==0) {
      stroke(#FFCC33);
      noFill();
      strokeWeight(8);
    }

    // calls 1 of 2 custom functions that translate
    // my latitude or longitude to an xy coordinate.
    //
    // that data is stored in the 2-dimensional array
    // latLong.  Since it is 2-dimensional, it has two
    // sets of brackets after the name, not just one,
    // like a typical one-dimensional array would use.

    // If I were going to store a tic-tac-toe board
    // using a 2-dimensional array, it'd look like this:
    //   tictactoe[x][y]  
    // or
    //   tictactoe[column][row]
    // If we assume the top row is row 0, and the leftmost
    // column is column 0, then the center square
    // in our tictactoe board would be stored in 
    //   tictactoe[1][1]
    // The upper right-hand square would be at 
    //   tictactoe[0][2]

    // Imagine I want an array to store data about the
    // windows in a building.  Each value should indicate
    // whether the lights are on (illuminated) or off (dark).
    // Say the building is 20 stories high, and there
    // are 8 windows per floor.  If we wanted to turn
    // on all of the windows in the building, we might
    // do this:

    /*
    for (int x=0;x<8;x++) {
     for (int y=0; y<20;y++) {
     windowIsLit[x][y] = true;
     }
     }
     */

    // If we wanted to turn off the lights on the
    // topmost floor only?  We might do thus:
    /*
    for (int x=0; x<8; x++) {
     windowIsLit[x][19] = false;
     }
     */

    float x=lonToScreen(latLong[recordID][1]);
    float y=latToScreen(latLong[recordID][0]);

    // take that data and send it into my custom function
    // that draws a pattern with the information.

    patternize(x, y);
    
    // these are optional steps that
    // add more dots to the screen...

//    /*
    patternize(x*1.10,y);
    patternize(x*0.90,y);
    patternize(x,y*1.025);
    patternize(x,y*0.975);
  //  */
  }
  // don't really need to plot every point.
  
  recordID=recordID+2;
  
  if (recordID > latLong.length) {
    saveFrame("DC_Commute_series5-####.png");
    noLoop();
  }
}

void dataParse() {

  maxLat= 38.9;
  minLat= 38.55;
  maxLon = -76.5;
  minLon = -77.5;

  // load our data into a giant String array.
  // each new line gets a new array element.
  // e.g., each array element (transitMap[4], e.g.)
  // is one "row" from our original file.

  String[] transitMap = loadStrings("dayInTheLife.csv");

  // Now:  Each element / line has several distinct values.
  // We need to further break up every single line.

  // Let's give dimension to our array:  
  // it will be [record quantity] by [2]
  // this is overkill, really:  only 2 records in that second
  // dimension (i.e., "latitude" and "longitude"), means we could've
  // just used 2 different 1-dimensional arrays ("longitude[recordID]")
  // and ("latitude[recordID]").  But this approach will still work fine.

  // first, set aside the right amount of memory -- the computer
  // needs to know what to expect...
  latLong = new float[transitMap.length][2];

  // now count through each element and fill each up.
  for (int recordID=0; recordID<transitMap.length; recordID++) {

    // split each line of our big file -- we only want
    // to keep the 1st cell (number 0) and the 2nd (number 1).
    // There is a 3rd, 4th, and 5th cells, but they are
    // meaningless to us.  So we ignore them.

    // split() is a fun function.  Really!
    // here, it is taking a row from our data and
    // splitting it at all of the commas.  So:
    // "23.34, 56.3, 775.54, "James", TRUE, "Festivals"
    // becomes
    // "23.35" and
    // "56.3" and
    // "775.54" and
    // "James"

    String[] element = split(transitMap[recordID], ",");


    // Our one remaining issue?  We pulled the data in
    // as a set of strings -- always a safe
    // way to do things, since Strings can include just
    // about any kind of data.  But "75" and 75 are not the
    // same.  So we need to convert "75" into 75...

    // To do that, we'll use a float() function, which
    // forces a String or an int to convert to a float.
    
    latLong[recordID][0] = float(element[1]);
    latLong[recordID][1] = float(element[0]);
  }
}

void initScreen() {
  rectMode(CENTER);
  fill(255);
  background(2);
  stroke(255);
  strokeWeight(1);
  background(#003366); // blue
}


void variableSetup() {
  // percentage of screen, allowing for margins
  xMax=width*.85;
  xMin=width*.15;
  yMax=height*.9;
  yMin=height*.1;
}

float latToScreen(float latitude) {
  // inverted, because we're in the northern/western quadrant
  float n=map(latitude, maxLat, minLat, yMin, yMax);
  // println(n);
  return n;
}

float lonToScreen(float longitude) {
  // inverted:  Western hemisphere, northern hemisphere
  float n=map(longitude, maxLon, minLon, xMax, xMin);
  return n;
}

void patternize(float myX, float myY) {

  // basically repeat the same point placement
  // but from 4 different degrees-zero.

  // notice the simple symmetry at work here.
  point(myX, myY);
  point(myX, height-myY);
  point(width-myX, myY);
  point(width-myX, height-myY);
}

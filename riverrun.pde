// glemasters georgetown 2014 cct
//
// global variables

PFont myFont;

// oooh, we're using arrays here.
// arrays kick ass, but they can be
// a bit challenging.  In effect, instead
// of having a bunch of variables like
// name1, name2, name3, and name4, we
// can do this:
// name[n], where n is 1,2,3 or 4 (or 800,etc).
// Why does that matter?  Because then
// I can do this:
// <inside the draw() loop>
// text(name[n],100,n*20);
// n=n+1;
// <repeat those lines as often as you please>
//
// You cannot do that with name1, name2.
// We'll play with these later.

String[] firstLine;

void setup() {
  size(1024, 768);
  myFont = createFont("Avenir", 64);
  textFont(myFont,64);
  textAlign(CENTER);
  smooth(8);
  // Note that there is an extra step in order
  // to prep arrays for usage:  First I declare
  // a String array variable by saying:
  // String[] cityNames; (see the empty brackets?)
  // THEN I have to initialize the array by "sizing" it:
  // cityNames = new String[99];
  // This means my array size is 99 records long.
  // A regular String variable is 1 record long.
  // Then I can finally assign values:
  // cityNames[0] = "Toledo";
  // cityNames[1] = "Pittsburgh";
  // cityNames[2] = "Industrial City #13";
  // etc.
  firstLine = new String[8];
  firstLine[0]="ALL THIS HAPPENED, MORE OR LESS.";
  firstLine[1]="LOLITA, LIGHT OF MY LIFE, FIRE OF MY LOINS.";
  firstLine[2]="SOMEONE MUST HAVE SLANDERED JOSEF K., FOR ONE MORNING, WITHOUT HAVING DONE ANYTHING TRULY WRONG, HE WAS ARRESTED.";
  firstLine[3]="IT IS A TRUTH UNIVERSALLY ACKNOWLEDGED, THAT A SINGLE MAN IN POSSESSION OF A GOOD FORTUNE MUST BE IN WANT OF A WIFE.";
  firstLine[4]="THE NELLIE, A CRUISING YAWL, SWUNG TO HER ANCHOR WITHOUT A FLUTTER OF THE SAILS, AND WAS AT REST.";
  firstLine[5]="CALL ME ISHMAEL.";
  firstLine[6]="MISS BROOKE HAD THAT KIND OF BEAUTY WHICH SEEMS TO BE THROWN INTO RELIEF BY POOR DRESS.";
  firstLine[7]="RIVERRUN, PAST EVE AND ADAM'S.";
}

void draw() {
  background(#245C54);
  translate(width/2.0,height/2.0);
  
  // Ah, custom functions.  Here I use a function
  // I built, called doSpinText().  When I call that
  // function (which is just below the draw() function)
  // it expects 5 arguments:  an ID number so it can
  // find the right quote; radius; fontSize; rotation speed; color.
  // That first number -- called myText in the function below --
  // is used with the arrays we built above.  So:
  // when myText = 0, 
  // firstLine[myText] is "All this happened..."
  // when myText is 4,
  // firstLine[myText] is "The Nellie, a cruising yawl..."
  
  doSpinText(0, 335, 98, .4, #FFCA8E);
  doSpinText(1, 198, 58, -.3, #FFCA8E);
  doSpinText(2, 250, 22, -.2, #EDA062);
  doSpinText(3, 273, 28, .1, #FF4000);
  doSpinText(4, 300, 42, -.1, #EDA062);
  doSpinText(7, 141, 62, .2, #FF4000);
  doSpinText(6, 415, 36, -.15, #E57734);
  doSpinText(5, 98, 46, -.4, #E57734);
}

// Here is my custom function.  I built it because
// my code was going to need to do 1 thing repeatedly.
void doSpinText(int myText, int myRadius, int fontSize, float txtSpeed, color myCol) {
  // a local variable.  Why use a local variable here?
  // because I come to this function for many different lines
  // of text, and each of their arclengths will be different.
  // I don't want to save that information.  I just start fresh each time.
  float arclength = 0;
  
  // myCounter is local here, but that doesn't matter too much.
  // I'm using it to calculate a gentle back and forth movement,
  // building on frameCount (which is a system variable).  frameCount
  // is always increasing, by 1, for every frame that ticks by when
  // you run your code.  It is like the guy at a cinema who counts
  // each film-goer with a hand-held clicker as they enter the theater.
  // That gradual but even change is invaluable when you want to use
  // sin, cos, asin, acos, tan, etc.
  
  float myCounter=sin(frameCount*0.005)*1000;
  textFont(myFont, fontSize);
  fill(myCol);
  
  
  float startPos=radians(myText*25);
  
  // This loop is the heart of the system.
  // It doesn't just print the text to the screen.
  // Instead, I go letter by letter, one at a time.
  // 1.  Grab the letter (as "currentChar");
  // 2.  Calculate its wide (as w);
  // 3.  Add to the total length of my arc;
  // 4.  With theta, do some math to find out where my letter should go;
  // 5.  Push matrix = save my screen configuration;
  // 6.  Move from the center (where we were previously) to
  //     the position of my current letter;
  // 7.  Now rotate so that the letter's base is against the
  //     imaginary ellipse of the circle;
  // 8.  Now stamp the character on the screen;
  // 9.  popMatrix == snap back to the middle of the screen
  // 10. arclength += w/2.5 is really just:
  //     arclength = arclength + (w/2.5);
  //     That just moves us further down the sentence's arc (w/2.5
  //     is the right number of pixels, in this case, for the
  //     width of the letter we just 'printed'.
  //
  //     Now just repeat it all again.
  
  for (int i = 0; i < firstLine[myText].length(); i++) {
    char currentChar = firstLine[myText].charAt(i);
    float w = textWidth(currentChar);
    arclength += w/2.5;
    float theta = radians(myCounter*txtSpeed*0.25) + startPos + arclength / myRadius;    

    pushMatrix();
    // Polar --> cartesian
    translate(myRadius*cos(theta), myRadius*sin(theta));
    rotate(theta+HALF_PI);
    text(currentChar, 0, 0);
    popMatrix();
    arclength += w/2.5;
  }
}

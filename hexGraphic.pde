// simple hex / faux 3D effect
// using custom functions
// glemasters, georgetown cct 2017

// custom functions near bottom

// globals here
color[] kuler =       {
   #FFAA5C, 
   #DA727E, 
   #AC6C82, 
   #685C79, 
   #455C7B
   };
//   #45334A, 
  // #796B7D, 
//   #CCC4B0, 
 //  #FFF1B5, 
  // #FFA3A3
  // };
 /*{#7F7364,#CBB08E,#CBC1B7,#789DCB,#646F7F};
  #2E0927, 
  #D90000, 
  #FF2D00, 
  #FF8C00, 
  #04756F
};*/

void setup() {
  size(600, 600, FX2D);
  background(255);
  stroke(0);
  frameRate(0.5);
  strokeWeight(1);
}

void draw() {
  background(kuler[int(random(kuler.length))]);

  int count = int(random(80,250));
  for (int i=0; i<count; i++) {
    // pixels per side of hex
    float side = 40.0;

    // random kolor, random alpha
    // I calculate alpha in this fashion so that
    // there aren't 255 different levels of transparency.
    float alpha = 255-int(random(5))*50;
    fill(kuler[int(random(kuler.length))], alpha);
    float strokeInk = int(random(2))*255;
    stroke (strokeInk,99);

    pushMatrix();
    // cheating a bit here.  I want my shapes
    // to cluster nearer middle of screen, so I'm
    // getting the proposed x (and proposed y) twice
    // and then taking the average -- 
    // essentially weighting the
    // the middle of the screen.
    
    float hexPosX = (chooseX(side)+chooseX(side))*0.5;
    float hexPosY = (chooseY(side)+chooseY(side))*0.5;
    translate(hexPosX, hexPosY);
    float n = int(random(1, 6)) * 0.25;
    makeHexSeries(side * n);
    popMatrix();
  }
  saveFrame("hexacles_v1_" + count + "####.png");
}



// custom functions from here forward

void makeHexSeries(float sideLength) {
  float interiorRadius = sqrt(3.0) / 2.0 * sideLength;
  float exteriorRadius = sideLength * 0.5;
  showMeTheHex(0, 0, sideLength);
}



// by passing an x and a y position to this
// next custom function, I can
// count on it to put the hex
// exactly where I want it.  Alternatively,
// I could use translate().  For example:
//
// translate(100,200);
// showMeTheHex(0,0,50);
// 
// gives the same result as
//
// showMeTheHex(100,200,50);
//

void showMeTheHex(float xPos, float yPos, float circumRadius) {
  beginShape();
  for (int angle = 0; angle < 360; angle=angle + 60) {
    float x = cos(radians(angle)) * circumRadius;
    float y = sin(radians(angle)) * circumRadius;
    vertex(x + xPos, y + yPos);
  }
  endShape(CLOSE);
}


// this is more complex than it needed to 
// be.  I just needed x and y positions
// that were random-ish, but not completely
// random.  Note that instead of void,
// we start with float -- that's because
// the computer will be expecting a floating-
// point value to be produced by this function.
// That's why we end with "return xFinal;"

float chooseX(float s) {
  float unitSize = s;
  float r = (width * 0.8) % unitSize;
  r = r * 0.5;
  float startLeft = (width * 0.1) + r;
  float stopRight = (width * 0.9) - r;
  float totalLength = stopRight-startLeft;
  float unitsComprised = int(totalLength / unitSize);
  int n = int(random(unitsComprised));
  float xFinal = startLeft + (n * unitSize) + (s * 0.5);
  return xFinal;
}


float chooseY(float s) {
  float unitSize = s;
  float r = (height * 0.8) % unitSize;
  r = r * 0.5;
  float startTop = (height * 0.1) + r;
  float stopBottom = (height * 0.9) - r;
  float totalLength = stopBottom-startTop;
  float unitsComprised = int(totalLength / unitSize);
  int n = int(random(unitsComprised));
  float yFinal = startTop + (n * unitSize) + (s * 0.5);
  return yFinal;
}

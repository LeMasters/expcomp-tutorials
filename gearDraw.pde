// glemasters cct georgetown 2017 
// relatively simplistic gear-builder.
// makes use of CUSTOM SHAPES as well as
// CUSTOM FUNCTIONS.  This code does
// NOT use curves, however -- that would
// be the next step.

// how many teeth for my gear?
// global variable
int toothCount;

void setup() {
  size(500,500, FX2D);
  smooth(8);
  strokeWeight(3);
  toothCount = 18; 
  // spacing depends (for now) on symmetry:
  // don't set toothCount to, e.g., 35!
}

void draw() {
  background(100);
  translate(width*0.5,height*0.5);
  rotate(radians(frameCount*0.1));
  // note that I'm doing this the long way
  // in order to help make it clearer.  It
  // doesn't have to be this long and complicated,
  // though.
  
  // To get width of tooth, multiply number of
  // teeth by 2 (tooth and depression);
  // divide 360 by that number.  That's
  // the number of degrees we'll need
  // for every unit we generate below
  
  // This is fun!  we start building
  // a custom shape, then call
  // our custom function n times,
  // then close up our custom shape!
  // That's a lot of tiny lines, all
  // linked together into one shape!
  
  beginShape();
  for (int i=0;i<toothCount; i++) {
    gearBuilder(i);
  }
  endShape(CLOSE);
}

// our custom function, "gearBuilder",
// needs to be told which tooth it is 
// drawing.  Using a global variable,
// it already knows the total quantity of teeth.

void gearBuilder(int gearID) {
  float innerCirc = 150;
  float outerCirc = 164;
  // determine tooth length in degrees
  // assumes tooth and recess are same
  //
  float w = 360 / (toothCount*2);
  float arcPos = w * gearID*2;
  float toothWidth = w;

  float x1 = cos(radians(arcPos))*innerCirc;
  float y1 = sin(radians(arcPos))*innerCirc;
  arcPos = arcPos + (toothWidth * 0.5);
  float x2 = cos(radians(arcPos))*innerCirc;
  float y2 = sin(radians(arcPos))*innerCirc;
  
  // no change in arcPos here, just move out
  // away from center of gear
  float x3 = cos(radians(arcPos))*outerCirc;
  float y3 = sin(radians(arcPos))*outerCirc;
  arcPos = arcPos + toothWidth;
  float x4 = cos(radians(arcPos))*outerCirc;
  float y4 = sin(radians(arcPos))*outerCirc;
  
  // now just move in towards center
  float x5 = cos(radians(arcPos))*innerCirc;
  float y5 = sin(radians(arcPos))*innerCirc;
  
  // round it out with half distance
  arcPos = arcPos + (toothWidth * 0.5);
  float x6 = cos(radians(arcPos))*innerCirc;
  float y6 = sin(radians(arcPos))*innerCirc;
  
  // let's draw it.
  vertex(x1,y1);
  vertex(x2,y2);
  vertex(x3,y3);
  vertex(x4,y4);
  vertex(x5,y5);
  vertex(x6,y6);
}

  // let's say:
  // we have two ellipses
  // one is 100 diameter (inner)
  // one is 120 diameter (outer)
  // find a point along the inner circumference;
  // move 1/2 a unit to right along circumference;
  // make a point;
  // move to same place on outer circumference;
  // drop a point;
  // move to right a full unit;
  // drop a point;
  // go back down to inner circumference;
  // make a point;
  // move right 1/2 unit/
  // final point.

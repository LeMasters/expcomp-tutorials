// glemasters / cct georgetown 2017

// Quick XY finder PLUS
// Left-click on the mouse to mark the spot
// The coordinates appear in your console
// Now with ACCU-CLICK.

// How to get your X-Y coordinates to look their best?
// Let's try rounding them to the nearest multiple
// of 20 (or, if you like, 10, or 5, or 71!)

// I've rebuilt this code from the previous program
// in order to show that a program is never finished.
// You can always go back and reuse parts of it to
// create newer, better things.

// Some principles I'll use in this code:
// global variables
// local variables

// global variables!
// global variables are the American celebrities
// of your code:  Everyone recognizes them,
// but nobody really likes them.  When I define
// a global variable, I know that no matter where
// I use it, the rest of my code will recognize
// its value.  The downside?  Huge memory footprint.
// Wastes space.  Makes far too many sequels.

int chunk; // our global integer, "chunk"

// no value yet for chunk.  But we have
// said "Its an int!"  (an integer; a whole number)

void setup() {
  size(500, 500);
  smooth(8);
  background(160);
  strokeWeight(1);
  stroke(#000000);
  fill(#FFFFFF);

  // let's assign a value to chunk
  // Try changing this value to make 
  // your grid more or less granular.
  chunk = 25;
}

void draw() {
  // Remember this loop has to be here.
  // In spite of the fact that its empty.
  // It is like an engine.
}

void mousePressed() {
  // This function gets called whenever you
  // press a mouse button.  But before
  // we react, we want to "smooth" 
  // those XY values first!

  // There are 1,000 ways to do this.  This is
  // just what makes sense to me.  You should
  // do what makes sense to you.

  // remember how chunk was a global variable?
  // Here, I'm going to use a whole bunch of
  // variables -- but they'll all be LOCAL,
  // not global.  They'll be born, work hard,
  // and die in obscurity.  None of my code
  // outside of this tiny section will ever
  // hear of xP or yP or x or y.  Why use them?
  // Very low memory footprint; reliable; 
  // predictable.  When I use a local variable,
  // I know where it's been.  Global celebrity
  // variables?  Who knows.
  
  float xP;  // all local
  float yP;
  float x;
  float y;
  
  xP = round(mouseX/chunk);
  yP = round(mouseY/chunk);
  x = xP * chunk;
  y = yP * chunk;
  
  ellipse(x, y, 8, 8);
  println(x + ", " + y);
} 

// as soon as my program hits that last
// closing curly brace, the mousePressed()
// function ends, the computer takes all of those
// local variables and destroys them.  Forever.
// Forgets they ever existed.  
// Next time we press a mouse button,
// we'll have to do the whole thing over again.

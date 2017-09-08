// Quick XY finder
// Left-click on the mouse to mark the spot
// The coordinates appear in your console

// NB:  mouseX and mouseY are "system variables."
// You cannot ASSIGN values to them, but you can
// READ values from them.  Which is handy, because
// they always contain the X and Y of the mouse position.

void setup() {
  size(500, 500);
  smooth(8);
  background(160);
  strokeWeight(1);
  stroke(#000000);
  fill(#FFFFFF);
}

void draw() {
  // empty... but the empty
  // draw() loop still needs to
  // be here for technical reasons.
}

void mousePressed() {
  ellipse(mouseX, mouseY, 6, 6);
  println(mouseX + ", " + mouseY);
}

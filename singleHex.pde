// a hex, a single hex.
// glemasters, expressive computation,
// georgetown cct 2017


float circumRadius;

void setup() {
  size(500, 500);
  background(30, 20, 26);
  noFill();
  stroke(255);
  fill(#E077A0);
  strokeWeight(12);
  circumRadius = 110;
  noLoop();
}

void draw() {
  translate(width/2, height/2);
  beginShape();
  for (int angle = 0; angle<360; angle=angle+60) {
    float x = cos(radians(angle))*circumRadius;
    float y = sin(radians(angle))*circumRadius;
    vertex(x, y);
  }
  endShape(CLOSE);
}

// using different techniques
// to position objects at an angle

void setup() {
  size(500, 500);
  // just run once, svp
  noLoop();
  noStroke();

  translate(width/2, height/2);
  float n = radians(90);
  float radius = 150;
  float x = cos(n)*radius;
  float y = sin(n)*radius;
  fill(240,30,40);
  ellipse(x, y, 50, 50);
}

void draw() {
  translate(width / 2, height / 2);
  rotate(radians(90));
  translate(150, 0);
  fill(#FFCC33);  
  ellipse(0, 0, 25, 25);
}

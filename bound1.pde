
// our global variables

float margin, w, h;
float ballX, ballY, ballDia;
float velX, velY;

void setup() {
  size(600, 600);
  margin = 15;
  // set up ball's initial position
  // random function takes 2 arguments:
  // lowest possible, highest possible
  // it returns a floating point number
  ballX = random(margin, width-margin);
  ballY = random(margin, height-margin);

  // we can also randomize our velocity
  velX = random(-1, 1);
  velY = random(-1, 1);

  // ball diameter
  ballDia = 12;

  // that's it, we're done setting up!
}

// remember:
// this function loops constantly
// 60x a second
// updating the screen each time

void draw() {
  // clear the screen 
  background(0);

  // now draw our ball.
  ellipse(ballX, ballY, ballDia, ballDia);

  // That's done.  Now we do some behind-the-scenes
  // stuff to get ready for the next screen update!

  // calculate the ball's new position:
  // remember -- since we already drew the ball
  // (above), it won't appear at these coordinates
  // until the next frame... We're just doing it
  // ahead of time.
  ballX = ballX + velX;
  ballY = ballY + velY;

  // Now we do our boundary checks.
  // Remember that we used fresh, local variables
  // Which means we have to declare them
  // and assign value to them every time we run
  // this function.
  float boundL;
  boundL = margin;

  float boundR;
  boundR = width-margin;

  // here's the shortcut to declare+assign
  // it only requires one line instead of two.
  float boundT = margin;
  float boundB = height - margin;

  // Now that we know our boundary locations,
  // let's perform some conditional checks,
  // in order to see if the ball will go out
  // of bounds the next time we draw it...

  // check X axis on right
  if (ballX>boundR) {
    velX = velX * -1.0;
  }

  if (ballX<boundL) {
    velX = velX * -1.0;
  }

  // remember -- we're not changing anything
  // about the ball in particular -- just reversing 
  // the velocity.  It is fairly easy, because:
  // n * -1 = -n;
  // and
  // -n * -1 = n;
  // Multiplying by -1 works wonders here.

  // now we'll check the y axis
  // I'm going to combine the two checks into one
  // I'll use boolean OR:  
  //    If too far up OR too far down then change direction
  // If I used boolean AND, the ball would never change:
  //    If too far up AND too far down, then change direction
  if (ballY>boundB || ballY < boundT) {
    velY = velY*-1.0;
  }
  // Also note that this only works so long as I want
  // either case to cause to the same action:
  // If I wanted the top boundary to trigger a sound 
  // and the bottom boundary to flash some text on
  // the screen, I'd need to have separate conditionals
  // for each.
}

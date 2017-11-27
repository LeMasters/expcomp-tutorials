// Ball class -- objectBreaker

class Ball {
    float positionX, positionY;
    int diameter;
    float xVelocity, yVelocity;
    color ballColor;

    Ball (float tpositionX, float tpositionY, int wd, float txV, float tyV, color tcol) {
        positionX=tpositionX;
        positionY=tpositionY;
        diameter = wd;
        xVelocity=txV;
        yVelocity=tyV;
        ballColor=tcol;
    }

    void move() {
        positionX = positionX + xVelocity; // calculate new x position of the ball
        positionY = positionY + yVelocity; // calculate new y position of the ball
    }

    void show() {
        fill(ballColor);
        rect(positionX, positionY, diameter, diameter);
    }

    // did we hit a wall?  then reverse direction!
    void boundaryCheck() {
        if (positionX+1>=width-diameter || positionX<=1) {
            xVelocity*=-1.0;
        }
        // did we hit the ceiling or the floor?  Reverse!
        if (positionY+1>=height-diameter || positionY<=1) {  
            yVelocity*=-1.0;
        }
    }

    void bounceCheck(Brick targetBrick) {

        // To deal with the bricks, I'm going to use the Rectangle class
        // from Java ... imported as a library.  Why?
        // Because Java's Rectangle class (note the capital
        // R) includes some methods to let me quickly calculate
        // overlap.  Because it is already written in Java
        // chances are it is faster (by a small amount at least)
        // than any code I could write in Processing.

        // Note also that we only come here when we're already
        // confident that the ball is within striking distance
        // of a brick (we used the distance function, dist(),
        // to measure how far we were from each brick, and only
        // bothered doing these calculations when the distance
        // was less than 1.5x the brick's width.)

        // note that the Rectangle needs integer X,Y, so I have
        // to change my floatingpoint X,Y with int()
        Rectangle rBall = new Rectangle(int(this.positionX), int(this.positionY), this.diameter, this.diameter);
        Rectangle rBrick = new Rectangle(int(targetBrick.positionX), int(targetBrick.positionY), targetBrick.pixelsWide, targetBrick.pixelsHigh);
        Rectangle overlapArea = rBall.intersection(rBrick);

        // note that it is possible for both of these
        // expressions to be true -- in which case
        // there would be both a vertical reversal
        // and a horizontal reversal.
        
        if (overlapArea.width >= overlapArea.height) {
            this.verticalBounce();
        }
        if (overlapArea.height >= overlapArea.width) {
            this.horizontalBounce();
        }
    }

    void verticalBounce() {
        yVelocity = yVelocity * -1.0;
    }

    void horizontalBounce() {
        xVelocity = xVelocity * -1.0;
    }
}
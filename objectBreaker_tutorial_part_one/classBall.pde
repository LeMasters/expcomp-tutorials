// Ball class

// /////////////////////////////////
// ***Just ignore this for now.***
////////////////////////////////////

// It is here
// as a placeholder, in order to keep 
// errors from occuring while we
// focus on the bricks themselves.

class Ball {
    float positionX, positionY;
    int wide, high;
    float xVelocity, yVelocity;
    color ballColor;

    Ball (float tpositionX, float tpositionY, int wd, int hi, float txV, float tyV, color tcol) {
        positionX=tpositionX;
        positionY=tpositionY;
        high=hi;
        wide=wd;
        xVelocity=txV;
        yVelocity=tyV;
        ballColor=tcol;
    }

    void doMoveBall() {
        positionX = positionX + xVelocity; // calculate new x position of the ball
        positionY = positionY + yVelocity; // calculate new y position of the ball
    }

    void doDrawBall() {
        fill(ballColor);
        rect(positionX, positionY, wide, high);
    }

    // did we hit a wall?  then reverse direction!

    void doBoundaryCheck() {
        if (positionX+1>=width-wide || positionX<=1) {
            xVelocity*=-1.0;
        }
        // did we hit the ceiling or the floor?  Reverse!
        if (positionY+1>=height-high || positionY<=1) {  
            yVelocity*=-1.0;
        }
    }

    void verticalbounce() {
        yVelocity = yVelocity * -1.0;
    }

    void horizontalbounce() {
        xVelocity = xVelocity * -1.0;
    }
}
// Ball class

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

    // lots to check, here.
    // Let's think about it:
    // We'll want to ask for a vertical bounce if:
    // Left edge of ball hits right edge of brick
    // right edge of ball hits left edge of brick
    // Or a horizontal bounce if:
    // bottom of ball collides with top of brick
    // top of ball collides with bottom of brick
    //
    // Again:  We could do this much more quickly,
    // but I'm drawing it out for (some) clarity.

    void bounceCheck(Brick hitBrick) {
        boolean vBounce = false;
        boolean hBounce = false;
        // left corner ball hits 
        float left = ((hitBrick.positionX + hitBrick.pixelsWide) - this.positionX);
        float right = ((this.positionX + this.diameter) - hitBrick.positionX);
        float bottom = ((hitBrick.positionY + hitBrick.pixelsHigh) - this.positionY);
        float top = ((this.positionY + this.diameter) - hitBrick.positionY);
        println("left",left, "right",right, "top",top,"bottom", bottom);
        float h = min(left, right);
        float v = min(bottom, top);
        if (h<v) {
            vBounce = true;
            println("vBounce");
            noLoop();
        } else {
            if (h>v) {
                hBounce = true;
                println("hBounce");
                noLoop();
            } else {
                println("Mistake.");
                noLoop();
            }
        }
        // now call those routines -- easy to do since we're already
        // inside the gameBall object.

        if (vBounce) {
            this.verticalBounce();
            println("VB");
        }
        if (hBounce) {
            this.horizontalBounce();
            println("HB");
        }
    }

    void verticalBounce() {
        yVelocity = yVelocity * -1.0;
    }

    void horizontalBounce() {
        xVelocity = xVelocity * -1.0;
    }
}
class Brick {
    int positionX;
    int positionY;
    int pixelsWide;
    int pixelsHigh;
    color brickColor;
    boolean isAlive;

    Brick (int brickID, int wd, int hi, color tempCol, boolean toBe) {

        int rowNumber = int(brickID / totalBrickColumns);
        int columnNumber = brickID - (rowNumber * totalBrickColumns);
        int brickUnitWidth = brickWidth + mortarThickness;
        int brickUnitHeight = brickHeight + mortarThickness;        
        int idealX = brickUnitWidth * columnNumber;
        int idealY = brickUnitHeight * rowNumber;

        positionX = wallLeftLocation + idealX;
        positionY = wallTopLocation + idealY;

        pixelsHigh = hi;
        pixelsWide = wd;
        brickColor = tempCol;
        isAlive = toBe;
    }

    void showBrick() {
        fill(brickColor);
        rect(positionX, positionY, pixelsWide, pixelsHigh);
    }

    void destroyBrick() {
        // If we wanted to put some fancy brick-shattering animation
        // in our game, we would probably call it from here. We would
        // probably call a sound effect from here, too.  But for now,
        // we just need to record in side this brick object that 
        // isAlive is no longer True.
        isAlive = false;
    }

    // we called this from the main brick-by-brick
    // check routine.  When we call it, we pass a copy
    // of the current gameBall object -- a copy we
    // call ballCopy [the name was my idea, by the way.
    // I have all the best names.]
    boolean doCollisionCheck(Ball ballCopy) {
        // collision checking is an artform.  Depending
        // on the shape and velocity of your objects,
        // collision checking can eat up a huge 
        // portion of your cpu-cycle budget.  Figuring
        // out if and where complex shapes overlap
        // is easy for us, but difficult for computers.
        // Happily, this is one of the easiest cases
        // possible:  two horizontally-aligned rectangles.
        // (If they were tilted at different angles,
        // it becomes much harder, for example).

        // I'll do this as a series of simple questions.
        // If it were more complex than this, I'd proabably
        // prefer to use a specialized (and very fast)
        // library, like box2D (the library used, for example,
        // in the original version of the angrybirds game).
        /*
        Rectangle ba = new Rectangle(int(ballCopy.positionX),int(ballCopy.positionY),ballCopy.diameter,ballCopy.diameter);
         Rectangle br = new Rectangle(this.positionX,this.positionY,this.pixelsWide,this.pixelsHigh);
         Rectangle baArea = ba.getBounds();
         Rectangle brArea = br.getBounds();
         Rectangle i = baArea.intersection(brArea);
         println(i);
         noLoop();
         
         ///       // .intersection(br.getBounds);
         */
        boolean xAxisImpact1 = false;
        boolean xAxisImpact2 = false;
        boolean yAxisImpact1 = false;
        boolean yAxisImpact2 = false;
        // I'm pre-loading these values as "false."  I will only
        // set them to true when I detect a collision -- which
        // means if there is no collision, they'll stay false.
        // This is far more granular than it needs to be, I'm
        // just divvying everything up for clarity.  The whole
        // routine can fit into one line pretty easily.

        // if both of these are true, then the whole ball xaxis is inside the brick
        // which means we must've hit the bottom/top of the brick
        float overlapX1 = 0;
        float overlapX2 = 0;
        float overlapY1 = 0;
        float overlapY2 = 0;
        
        float leftBrick = this.positionX;
        float rightBrick = this.positionX + this.pixelsWide;
        float topBrick = this.positionY;
        float bottomBrick = this.positionY + this.pixelsHigh;
        float leftBall = ballCopy.positionX;
        float rightBall = ballCopy.positionX + ballCopy.diameter;
        float topBall = ballCopy.positionY;
        float bottomBall = ballCopy.positionY + ballCopy.diameter;
        if (leftBrick > rightBall || leftBall > rightBrick || topBrick > bottomBall || bottomBrick < topBall) {
            // we are outside the x or y axis areas of impact
            return false;
        }
        // now we know someone is in the rectangular area of impact.
        float cBrX = (leftBrick + rightBrick) * 0.5;  
        float cBrY = (topBrick + bottomBrick) * 0.5;
        
        if (this.positionX + this.pixelsWide >= ballCopy.positionX) {
            xAxisImpact1 = true;
            overlapX1 = max(this.pixelsWide, ballCopy.diameter) - ((this.positionX + this.pixelsWide) - ballCopy.positionX);
            if (overlapX1<0) {
                overlapX1 = 0;
            } else {
            }
        }
        if (ballCopy.positionX + ballCopy.diameter >= this.positionX) {
            xAxisImpact2 = true;
            overlapX2 = ballCopy.diameter - ((ballCopy.positionX + ballCopy.diameter) - this.positionX);
            if (overlapX2<0) {
                overlapX2=0;
            } else {
            }
        }
        if (this.positionY + this.pixelsHigh >= ballCopy.positionY) {
            yAxisImpact1 = true;
            overlapY1 = max(this.pixelsHigh, ballCopy.diameter) - ((this.positionY + this.pixelsHigh) - ballCopy.positionY);
            if (overlapY1<0) {
                overlapY1 = 0;
            } else {
            }
        }
        if (ballCopy.positionY + ballCopy.diameter >= this.positionY) {
            yAxisImpact2 = true;
            overlapY2 = ballCopy.diameter - ((ballCopy.positionY + ballCopy.diameter) - this.positionY);
            if (overlapY2<0) {
                overlapY2 = 0;
            } else {
            }
        }

        // Now use Boole's algebraic logic to determine our answer:
        if (xAxisImpact1 && xAxisImpact2 && yAxisImpact1 && yAxisImpact2) {
            println(overlapX1,overlapX2,", ",overlapY1,overlapY2);

            //
            // && means "Boolean AND"
            // The line above will ONLY return "true" when all 4 of those
            // values are true.  If one is false, we'll get an answer of false.

            // and send back our answer:  Was this a collision or not?
            return true;
        } else {
            return false;
        }
    }
}
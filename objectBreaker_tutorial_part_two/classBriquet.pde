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

        boolean xAxisImpactA = false;
        boolean xAxisImpactB = false;
        boolean yAxisImpactA = false;
        boolean yAxisImpactB = false;
        // I'm pre-loading these values as "false."  I will only
        // set them to true when I detect a collision -- which
        // means if there is no collision, they'll stay false.
        // This is far more granular than it needs to be, I'm
        // just divvying everything up for clarity.  The whole
        // routine can fit into one line pretty easily.

        if (this.positionX + this.pixelsWide >= ballCopy.positionX) {
            xAxisImpactA = true;
        }
        if (this.positionX <= ballCopy.positionX + ballCopy.diameter) {
            xAxisImpactB = true;
        }
        if (this.positionY + this.pixelsHigh >= ballCopy.positionY) {
            yAxisImpactA = true;
        }
        if (this.positionY <= ballCopy.positionY + ballCopy.diameter) {
            yAxisImpactB = true;
        }

        // Now use Boole's algebraic logic to determine our answer:
        if (xAxisImpactA && xAxisImpactB && yAxisImpactA && yAxisImpactB) {
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
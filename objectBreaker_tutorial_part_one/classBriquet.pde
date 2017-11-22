// When the ball hits a brick,
// I change its "alive or dead?" value to "dead".
// When a brick is "dead", the program knows not to 
// bother drawing it on the screen.

class Brick {
    int positionX;
    int positionY;
    int wide;
    int high;
    color brickColor;
    boolean isAlive;

    Brick (int brickID, int wd, int hi, color tempCol, boolean toBe) {

        // calculate x,y position using one-dimensional value: brickID
        // if you look in the properties section, above the constructor,
        // you'll see that I never store brickID.  I could, but since these
        // bricks don't move, I can trust that, with a little math,
        // BrickID will always yield the same X and Y, and vice versa.

        // get total number of full rows first (by dividing by # columns)
        int rowNumber = int(brickID / totalBrickColumns);

        // current column number is the remainder
        int columnNumber = brickID - (rowNumber * totalBrickColumns);

        // now get their ideal pixel positions onscreen
        int brickUnitW = brickWidth + mortarThickness;
        int brickUnitH = brickHeight + mortarThickness;        
        int idealX = brickUnitW * columnNumber;
        int idealY = brickUnitH * rowNumber;

        // now account for margins on top and the left
        // and we've got our first real properties!
        positionX = wallLeftLocation + idealX;
        positionY = wallTopLocation + idealY;

        // brick height and width; again, always the same
        // but I'm storing them anyway.  Maybe at some point,
        // I want to play with "chipping away" at the bricks,
        // etc.

        high = hi;
        wide = wd;
        brickColor = tempCol;
        isAlive = toBe;
    }

    // showBrick just draws the brick to the screen
    // using previously determined XY coordinates, dimensions,
    // and color
    void showBrick() {
        fill(brickColor);
        rect(positionX, positionY, wide, high);
    }

    // Ooooh!  Let's kill a brick!  Here's where we do it.
    void destroyBrick() {
        isAlive = false;
    }

    // each brick is responsible for monitoring
    // its edges for a collision.  We send each
    // brick the latest data on the ball position
    // (by sending it a copy of the ball itself)
    // each time we check -- i.e., every
    // time the draw() loop runs.

    boolean doCollisionCheck(Ball ballCopy) {
        // more on this later...
        return false;
    }
}
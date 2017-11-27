// Brickbreaker code part 3
// fall 2017
// Prof. Garrison LeMasters
// Georgetown University
// 
// Code licensed under Creative Commons 4.0
//

// In order to make the problem of detecting
// collisions between the ball and the bricks
// easier, I'm going to use a simple library 
// from Java (see the import statement below).
// Processing is built on top of Java, and Java
// programmers have created about a billion 
// libraries for the language (it's one of the
// reasons that Java is a security nightmare).
// Processing doesn't natively incorporate any of
// Java's libraries, but it can be made to without
// much effort:  anything that works in Java 
// should work reasonably well in Processing.

import java.awt.Rectangle;

color backgroundColor;
int wallTopLocation;
int wallBottomLocation;
int wallLeftLocation;
int wallRightLocation;
int brickHeight;
int brickWidth;
int mortarThickness;
int totalBrickRows;
int totalBrickColumns;
int wallHeight;
int wallWidth;
Brick[] gameBrick;
Ball gameBall;


void setup() {
    size(500, 500);
    smooth();

    backgroundColor = color(#455463);
    wallTopLocation = 60;  // 60 pixels from the top of the window
    totalBrickRows = 9; // 6 rows tall
    brickWidth = 16; // prescribed brick height and width
    brickHeight = 10;
    mortarThickness = 2; // space between bricks

    // just internal calculations to figure out how to place
    // the bricks evenly upon the screen, etc.  Some programmers
    // don't emphasize the step-by-step nature of things
    // like I do, preferring instead to just get on with
    // it:  They'll condense 4 of these lines into a single
    // line, for example.  I like dragging things out
    // and exposing how things work.  Both are good
    // approaches.

    int brickUnitWidth = brickWidth + mortarThickness;
    int brickUnitHeight = brickHeight + mortarThickness;

    wallHeight = brickUnitHeight * totalBrickRows;
    wallWidth = brickUnitWidth * int(width / brickUnitWidth);
    // totalBrickColumns will therfore yield an integer.
    totalBrickColumns = wallWidth / brickUnitWidth; 

    int leftOverWidth = width - wallWidth;
    wallLeftLocation = int(leftOverWidth * 0.5);

    // CALL THE CONSTRUCTORS
    // 1st, instantiate my bricks from the Brick class: 
    // I'll call each object a gameBrick[n]
    int totalBrickCount = totalBrickColumns * totalBrickRows;
    gameBrick = new Brick[totalBrickCount];
    for (int i = 0; i < totalBrickCount; i++) {
        // Brick class constructor wants:
        // ID, width of brick, height of brick, color, and isAlive boolean)
        gameBrick[i] = new Brick(i, brickWidth, brickHeight, color(#FFCC33), true);
    }
    // Now, a single ball object from the Ball class.
    // Ball class wants:
    // x, y, diameter, x velocity, y velocity, color
    gameBall = new Ball(width/2, height/1.85, 10, -1.25, -1, #FFFFFF);
}

void draw() {
    background(backgroundColor);
    doBrickRoutine();
    doBallRoutine();
}

// so how do we handle things?
// we go brick by brick.  Ask if the brick
// is alive; if it is, then (for each
// brick that we know is alive) we call the
// collision check routine and pass it a
// copy of the gameBall object (note that since
// we're going brick by brick, and we're calling
// the collision check routine of a specific
// brick -- gameBrick[i].doCollisionCheck() --
// and not some generic routine -- we don't have
// to tell the computer which brick we're interested
// in... we're already inside that particular brick.)
// (Note that we check to see if it is alive first
// because otherwise we're wasting our time).
// We tell the computer to store the result of that
// collision check route (a boolean) in the variable
// "brickHit".  Then if that value is true, we have
// to go destroy that brick.  OTHERWISE, we have
// to go show that brick.  Once finished, we take
// care of the rest of the bricks.

void doBrickRoutine() {

    // brickStrike is a last-minute addition.  I use it to keep
    // from destroying more than 1 brick per scan.  It is very
    // easy for the ball to strike two bricks simultaneously,
    // but accounting for that would require some extra code.
    // So we only care about the first impact, not any subsequent
    // impact.

    boolean brickStrike = false;
    for (int i = 0; i<gameBrick.length; i++) {
        if (gameBrick[i].isAlive == true) {
            gameBrick[i].showBrick();
            float n = dist(gameBrick[i].positionX, gameBrick[i].positionY, gameBall.positionX, gameBall.positionY);
            if (n < (gameBrick[i].pixelsWide)) {
                boolean hit = gameBrick[i].doCollisionCheck(gameBall);
                // here are different ways of reading the line below
                // if hit is true but NOT brickstrike 
                // if hit is true and brickstrike is false
                // if hit NOT brickstrike
                // The exclamation point that preceeds a variable
                // name (in this case) is called a "bang".
                // I could also write:
                // if (hit && !brickStrike) {
                // OR
                // if (hit == true && brickStrike != true) {
                if (hit == true && !brickStrike) {
                    brickStrike = true;
                    gameBrick[i].destroyBrick();

                    // But we're not done!  We still
                    // need to change the 
                    // direction of the ball bounce.
                    // Many ways to do that.  
                    // This is a long, detailed approach.
                    // (It is also very slow).
                    // I'm going to pass a copy of the 
                    // specific Brick that has been hit 
                    // into the gameBall method
                    // called bounceCheck()
                    // and figure out if we need to bounce
                    // vertically or horizontally.
                    gameBall.bounceCheck(gameBrick[i]);
                }
            }
        } else {
            gameBrick[i].thingsFallApart();
        }
    }
}

void doBallRoutine() {
    gameBall.move();
    gameBall.show();
    gameBall.boundaryCheck();
}

  ////////////////////////////////////////
 ///  Ball CLASS                     ///
////////////////////////////////////////

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

  ////////////////////////////////////////
 ///  BRICK CLASS                     ///
////////////////////////////////////////

class Brick {
    float positionX;
    float positionY;
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
        fill(this.brickColor);
        rect(this.positionX, this.positionY, this.pixelsWide, this.pixelsHigh);
    }

    void destroyBrick() {
        isAlive = false;
    }

    void thingsFallApart() {
        if (this.positionY < height) {
            this.positionY = this.positionY * 1.0125;
            this.showBrick();
        }
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
        // set them to true when I detect similar positions
        // to the left and right of the brick, and above
        // and below the brick (think of a cross with
        // a vertical line as wide as a brick and 
        // a horizontal line as tall as a brick, with
        // the brick itself in the very center).
        // This is just another way of figuring out
        // if one shape has touched another.
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
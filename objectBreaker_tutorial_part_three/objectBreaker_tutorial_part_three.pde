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
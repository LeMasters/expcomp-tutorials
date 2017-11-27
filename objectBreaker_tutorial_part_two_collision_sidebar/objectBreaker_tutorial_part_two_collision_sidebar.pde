// Brickbreaker code part 2
// fall 2017
// Prof. Garrison LeMasters
// Georgetown University
// 
// Code licensed under Creative Commons 4.0
//
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
    totalBrickRows = 6; // 6 rows tall
    brickWidth = 25; // prescribed brick height and width
    brickHeight = 15;
    mortarThickness = 5; // space between bricks
    int brickUnitWidth = brickWidth + mortarThickness;
    int brickUnitHeight = brickHeight + mortarThickness;

    wallHeight = brickUnitHeight * totalBrickRows;
    wallWidth = brickUnitWidth * int(width / brickUnitWidth);
    totalBrickColumns = wallWidth / brickUnitHeight; // yields a whole number

    int leftOverWidth = width - wallWidth;
    wallLeftLocation = int(leftOverWidth * 0.5);
    wallRightLocation = width - int(leftOverWidth * 0.5);
    wallBottomLocation = wallTopLocation + (totalBrickRows * brickUnitHeight);

    // instantiate my bricks: objects I'll call gameBrick[n]
    int totalBrickCount = totalBrickColumns * totalBrickRows;
    gameBrick = new Brick[totalBrickCount];
    for (int i = 0; i < totalBrickCount; i++) {
        int tempRedRow = int(i / totalBrickColumns);
        // Brick class constructor wants:
        // ID, width of brick, height of brick, color, and isAlive boolean)
        gameBrick[i] = new Brick(i, brickWidth, brickHeight, color(#FFCC33), true);
    }
    //instantiate the Ball class with a gameBall object.
    // Ball class wants
    // x, y, diameter, x velocity, y velocity, color
    gameBall = new Ball(width/2, height/1.85, 10, -1, -1, #FFFFFF);
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
    for (int i = 0; i<gameBrick.length; i++) {
        if (gameBrick[i].isAlive == true) {
            //    float n = dist(gameBrick[i].positionX, gameBrick[i].positionY, gameBall.positionX, gameBall.positionY);
            //  if (n<gameBrick[i].pixelsWide) {
            boolean hit = gameBrick[i].doCollisionCheck(gameBall);
            if (hit == true) {
               // gameBrick[i].destroyBrick();

                // Also we need to change the direction of the ball bounce.
                // Many ways to do that.  This is a long, detailed approach.
                // (It is also very slow).
                // I'm going to pass a copy of the specific Brick
                // that has been hit into the gameBall method
                // and figure out if we need to bounce
                // vertically or horizontally.  
                gameBrick[i].showBrick();
                gameBall.bounceCheck(gameBrick[i]);
            } else {
                gameBrick[i].showBrick();
            }
        }
    }
}
// we only need to look at one ball, while we needed
// to look at many bricks.  There is a bit more do
// do however, as we're in motion and the bricks
// were still.
void doBallRoutine() {
    gameBall.show();

    gameBall.boundaryCheck();
    gameBall.move();
}

void keyPressed() {
    loop();
}
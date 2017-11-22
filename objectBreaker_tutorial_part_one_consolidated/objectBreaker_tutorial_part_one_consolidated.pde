// Brickbreaker code part 1
// fall 2017
// Prof. Garrison LeMasters
// Georgetown University
// 
// Code licensed under Creative Commons 4.0
//

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

// a one-dimensional array of bricks,
// which we'll stack into a 2-dimensional
// wall of bricks.
Brick[] gameBrick;
Ball gameBall;


void setup() {
    size(500, 500);
    smooth();

    backgroundColor = color(#455463);
    wallTopLocation = 60;  // 60 pixels from the top of the window
    totalBrickRows = 6; // 6 rows tall
    brickWidth = 21; // prescribed brick height and width
    brickHeight = 21;
    mortarThickness = 2; // space between bricks
    
    // calculate total wall height
    // A brick is essentially 
    // width:  brickWidth PLUS mortarThickness,
    // height:  brickHeight PLUS mortarThickness
    // e.g. brick + empty space between it and next brick.
    
    // I call these "brickUnitW" and "brickUnitH" for simplicity's sake:
    int brickUnitW = brickWidth + mortarThickness;
    int brickUnitH = brickHeight + mortarThickness;

    wallHeight = brickUnitH * totalBrickRows;
    
    // calculate maximum number of whole bricks we can fit in a row.
    wallWidth = brickUnitW * int(width / brickUnitW);

    // we've now rounded down the number of brickUnits (int() rounds down)
    totalBrickColumns = wallWidth / brickUnitH; // yields a whole number

    // now account for leftover space by dividing it in half
    // and putting it on either side of the wall.

    int leftOverWidth = width-wallWidth;
    wallLeftLocation = int(leftOverWidth * 0.5);
    wallRightLocation = width - int(leftOverWidth * 0.5);

    wallBottomLocation = wallTopLocation + (totalBrickRows * brickUnitH);

    // here, we're figuring out how many bricks across by how many bricks 
    // down we need, then call the Brick class constructor
    int totalBrickCount = totalBrickColumns * totalBrickRows;
    gameBrick = new Brick[totalBrickCount];
    color temporaryColor;
    for (int i = 0; i < totalBrickCount; i++) {
        int tempRedRow = int(i / totalBrickColumns);
        if (tempRedRow%3 == 0) {
            temporaryColor = color(#FF3333);
        } else {
            temporaryColor = color(#FFCC00);
        }
            
        gameBrick[i] = new Brick(i, brickWidth, brickHeight, temporaryColor, true);
    }

    // let's finish by building a single brick-breaking ball.
    // Note that I'm not doing anything with the ball yet in this 
    // part of the tutorial.
    gameBall = new Ball(width/2, height/1.5, 11, 11, -1, -1.5, #FFCC33);
}

void draw() {
    
    background(backgroundColor);

    // I've got a single routine (function) here.
    // It is actually a collection of other
    // functions, but I consolidate things here
    // so that it is easier for me to keep track of.
    // In any event:  We do all of our
    // brick maintenance and drawing first.
    //
    // In the next installation of the tutorial,
    // we'll add ball-oriented stuff.

    doBrickRoutine();
    // the doBrickRoutine() is immediately below...
}

// this function draws our wall
// it draws all the bricks in a single row,
// and then it moves down to the next row.

void doBrickRoutine() {
    // Here, we'll decide if the brick is alive or dead.
    // Is it dead?  Then skip to next brick.
    // Alive?  Then ask "Did it just get hit by a ball?"
    // Yes --> kill it and go to next brick;
    // No --> then draw it and go to next brick.

    for (int i = 0; i<gameBrick.length; i++) {
        if (gameBrick[i].isAlive == true) {
            
            // note we're passing a copy of the gameBall
            // to every brick -- it will have all the latest
            // data on x position, y position of the ball
            boolean hit = gameBrick[i].doCollisionCheck(gameBall);
            if (hit == true) {
                gameBrick[i].destroyBrick();
            } else {
                gameBrick[i].showBrick();
            }
        }
    }
}

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
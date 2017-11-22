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
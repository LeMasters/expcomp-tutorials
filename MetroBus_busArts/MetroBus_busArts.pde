import jto.colorscheme.*; //<>//

//Garrison LeMasters Georgetown CCT 2017
//
// metrobus arts draft
// code November 15-17

import http.requests.*;

float totalX, totalY;
PVector[] outline;
busShape myBusShape;
ArrayList<routeList> myRouteList;


float x, y;
int f, b, s;
float edgeLeft, edgeRight;
float edgeTop, edgeBottom;
String timeStamp;
PImage metroBus;
PFont myFont;
String myScore;
boolean initialRequestFlag;
color[] workingPalette;
PImage monumentIcon;

String apiKEY, apiVALUE;

void setup() {
    size(900, 900, FX2D);
    smooth(8);
    frameRate(0.075);
    monumentIcon = loadImage("washingtonMonumental.png");
    metroBus = loadImage("metroLogo.png");
    metroBus.resize(int(width*0.9), 0);
    myFont = loadFont("SuperMario72.vlw");
//    myFont = loadFont("PICO-8-72.vlw");
    apiKEY = "api_key";
    apiVALUE = "b23a33173a6f44059e3f7a6c286cb881";

    edgeLeft = width * 0.15;
    edgeRight = width * 0.85;
    edgeTop = height * 0.15;
    edgeBottom = height * 0.85;
    myRouteList = new ArrayList<routeList>();
    createRouteList();
    monumentIcon = loadImage("washingtonMonumental.png");
}

void draw() {
    buildColorScheme();
    int r = int(random(myRouteList.size()));
    routeList tempRouteListObject = myRouteList.get(r);
    String routeToMap = tempRouteListObject.routeID;
    // we have to fix the value because Metro
    // includes values it considers invalid.
    String[] quickfix = splitTokens(routeToMap, "cv");
    routeToMap = quickfix[0];

    // traditional array here, just one bus shape at a time
    myBusShape = new busShape(routeToMap); 

    myBusShape.findEdges();

    // outline is a PVector array
    outline = myBusShape.buildShape();
    pixelPaint(outline);
    image(monumentIcon, width/2.8,height/2.23);
    saveFrame("pixelated-output-####.png");
    // noLoop();
}
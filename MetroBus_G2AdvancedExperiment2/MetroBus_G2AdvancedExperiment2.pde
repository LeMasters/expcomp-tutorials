import jto.colorscheme.*; //<>//

//Garrison LeMasters Georgetown CCT 2017
//
// metrobus arts draft
// code November 15-17

import http.requests.*;

float screenAreaHeight, screenAreaWidth;
float leftMargin, topMargin;
MetroBus myBus;
float totalX, totalY;
PVector[] outline;
BusRouteMap myBusRouteMap;
ArrayList<routeList> myRouteList;
float x, y;
int f, b, s;
float hMargin, vMargin;
String timeStamp;
PImage metroBus;
PFont myFont;
String myScore;
color[] workingPalette;
PImage monumentIcon;

String apiKEY, apiVALUE;

void setup() {
    size(850, 850, FX2D);
    smooth(8);
    rectMode(CENTER);
    frameRate(0.2);
    metroBus = loadImage("metroLogo.png");
    metroBus.resize(int(width*0.9), 0);
    myFont = createFont("Impact", 36);
    //    myFont = loadFont("PICO-8-72.vlw");
    apiKEY = "api_key";
    apiVALUE = "b23a33173a6f44059e3f7a6c286cb881";

    //  myBus = new MetroBus("G2", 0, 0, 0, millis());
    //(String bus, int ID, float lon, float lat, float lastUpdated) {

    myRouteList = new ArrayList<routeList>();
    createRouteList();
    hMargin = 20;
    vMargin = 20; // pixels, absolute
}

void draw() {
    buildColorScheme();
    int routePick = int(random(myRouteList.size()));
    routeList tempRoutePickObject = myRouteList.get(routePick);
    String wmataRouteName = tempRoutePickObject.routeID;

    // we have to fix the value because Metro's API
    // will return values it considers invalid elsewhere;
    // essentially route names (like "G2") have a few added
    // letters for internal purposes ("G2c", "G2cv", etc.).
    // we need to strip those letters off.  
    // splitTokens confines them to different array elements
    // String[] t = splitTokens("B36cv","cv") would yield
    // t[0] = "B36"... the "c" and "v" are removed
    // because they are considered "delimiters" -- even
    // though in this case, they are really information [the
    // difference is they aren't useful to me, so I'm treating
    // them as though they are mere delimiters.  The delimiter role
    // is commonly played by the comma, tab, or even space in simple
    // text-based data files.) This process works well for us here
    // because if there are none of the split tokens,
    // it just puts everything in to the 0th element of the array.
    // String[] t = splitTokens("R28","cv") yields simply
    // t[0] = "R28".  So t[0] is always where we want to go.
    // splitTokens() is super useful for data cleanup, especially
    // when combined with join();
    //
    String[] quickfix = splitTokens(wmataRouteName, "cv");
    wmataRouteName = quickfix[0];
    fill(workingPalette[f]);
    if (frameCount<1) {
        background(workingPalette[b]);
    }
    myBusRouteMap = new BusRouteMap(wmataRouteName);
    myBusRouteMap.findMapEdges();

    stroke(workingPalette[f]);
    if (frameCount<1) {
        paintLandmark();
    }
    // outline is a PVector array
    outline = myBusRouteMap.buildShape();
    pixelPaint(outline);
    myBus = new MetroBus(wmataRouteName, frameCount);
    myBus.showMetroBus();
    // noLoop();
    //  noLoop();
    // paintLandmark();
}
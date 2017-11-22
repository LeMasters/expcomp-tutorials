//Garrison LeMasters Georgetown CCT 2017
//expressive computation -- intermediate API use
//and simple data visualization; transit to P5JS
//
//Please make use of this code as you see fit.
//

import http.requests.*;

String timeStamp;
PImage metroBus;
PFont myType;
boolean initialRequestFlag;
Timer WMATAtimer;
Display myDisplay;
String apiKEY, apiVALUE;
String myStopID;
String myStopName;
String myStopBusRouteName;

void setup() {
    size(400, 600);
    frameRate(1);
    initialRequestFlag = true;
    myStopID = "";
    metroBus = loadImage("metroLogo.png");
    metroBus.resize(int(width*0.9), 0);
    myType = createFont("HelveticaNeue-CondensedBlack", 90);
    textFont(myType);
    timeStamp = "";

    // you want to try and avoid posting this online -- 
    // we can talk about strategies for obfuscation
    // if you are interested in pursuing it.
    apiKEY = "api_key";
    apiVALUE = "b23a33173a6f44059e3f7a6c286cb881";

    // create my display
   // myDisplay = new Display("G2", "minutes", 0, false);
    //WMATAtimer = new Timer(1);
}

void draw() {
    String temp = trainTracker();
    JSONObject trainStatus = parseJSONObject(temp);
    println(trainStatus);
    noLoop();
}

void defer_draw() {
    myDisplay.updateScreen();
    // First time through the draw() loop, the
    // myStopID String will be empty (see setup() above).
    // We ask..."Is it empty?"  If yes, then we do
    // a detour and look up that ID.  Once we have that
    // ID, though, we don't need to waste time looking it
    // up again ... until we stop the program and restart it.
    // 
    if (myStopID == "") {
        lookupStopID();

        // when we write software for people to use
        // we need to start thinking about how
        // it will break (and it will always, always break).
        // This is often called "graceful degradation," a
        // pretty awful term that is meant to imply
        // that breakage in one area won't mean the absolute
        // collapse of the whole system.
        // In this super simple example, I'll
        // just check myStopID AGAIN, after
        // I looked up the code... if it is
        // still a null, then something is broken...
        if (myStopID == "") {
            println("Something is broken.  kthxbye");
            noLoop();
        }

        // now we get to the business at hand
    } else {

        // check our WMATA timer to see if it is time
        // to update our bus distance...
        if (WMATAtimer.clockWatcher() || initialRequestFlag==true) {
            println(millis(), "starting query series");

            String tempJSONBusData = busDistanceQuery(myStopID);
            JSONObject tempJSONBusObj = parseJSONObject(tempJSONBusData);

            // JSONBreaker() is a function that actually
            // locates the number of minutes until the bus arrives.

            int predictedBusArrival = JSONBreaker(tempJSONBusObj);
            myDisplay.isActive = true;
            myDisplay.bus = "G2";
            myDisplay.units = "minutes";
            myDisplay.timeRemaining = predictedBusArrival;
            println(millis(), "-->", predictedBusArrival);
            createTimeStamp();

            // create new timer
            WMATAtimer = new Timer(64); // how many seconds between updates?
            WMATAtimer.start();
        }
    }
}

void timeStamp() {
    textAlign(LEFT);
    textSize(20);
    fill(128);
    text(("Last queried: "+timeStamp), 25, height-30);
}

void createTimeStamp() {
    String h = str(hour());
    String m = str(minute());
    String s = str(second());
    if (h.length()<2) {
        h = "0"+h;
    }
    if (m.length()<2) {
        m = "0"+m;
    }
    if (s.length()<2) {
        s = "0"+s;
    }
    timeStamp = h+":"+m+":"+s;
}
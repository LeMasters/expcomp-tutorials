import http.requests.*;

Display myDisplay;
String apiKEY, apiVALUE;
String myStopID;
String myStopName;
String myStopBusRouteName;

void setup() {
    size(400, 400);
    frameRate(1);

    myStopID = "";

    // you want to try and avoid posting this online -- 
    // we can talk about strategies for obfuscation
    // if you are interested in pursuing it.
    apiKEY = "api_key";
    apiVALUE = "b23a33173a6f44059e3f7a6c286cb881";

    // save the display for later use...
    // myDisplay = new Display("G2", "minutes", 0, false);
}

void draw() {
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
        // now we get along with the business at hand
    } else {
        String tempBusData = busDistanceQuery();
        JSONObject tempJSONData = parseJSONObject(tempBusData);
        int predictedBusArrival = JSONBreaker(tempJSONData);
        textSize(220);
        background(0);
        fill(255);
        text(predictedBusArrival, 40, height-120);
        textSize(28);
        text("Minutes until arrival",60,height-90);
        println("Note: At", millis(), "showing", predictedBusArrival, "minutes.");
        noLoop();
    }
}
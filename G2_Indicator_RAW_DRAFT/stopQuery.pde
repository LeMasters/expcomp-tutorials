// We'll make two queries.
// Not because we need to, but
// because it allows us to expand
// on this application later.
// For the moment, we'll just query
// to find out the bus stop near
// the following lat / long:
// 38.9053° N, 77.0697° W
// Which google identifies as the
// Car Barn.  That will return
// a StopID -- it will always return
// the same StopID, so we probably
// won't leave the code like this...
// We just want to show how it could
// be expanded to include other stops

String busStopIDQuery() {
    String baseURL = "https://api.wmata.com/Bus.svc/json/jStops";
    String latQuery = "?Lat=";
    String lngQuery = "&Lon=";
    String radQuery = "&Radius=";
    String myLat = "38.905833"; // CarBarn, 
    String myLng = "-77.069828"; // courtesy Google
    String myRad = "10"; // how many meters-radiant to search?
    // Seriously, though:  How amazing is it that
    // I can type "Carbarn Latitude Longitude" into Google
    // and get a precise answer?  I don't even need to say "DC"
    // or "Georgetown"?  

    String geoDataQuery = (latQuery + myLat) + (lngQuery + myLng) + (radQuery + myRad);
    String totalRequestLive = baseURL + geoDataQuery;
    GetRequest get = new GetRequest(totalRequestLive);
    get.addHeader(apiKEY, apiVALUE);

    get.send();
    String temp = get.getContent();
    return temp;
}
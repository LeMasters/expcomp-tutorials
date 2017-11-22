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
    println("Beginning busStopIDQuery()");
    // Note that I've broken this down a bit so that 
    // you can see how it comes together.  It is far
    // too granular here, though:  Easier just to
    // put most of it into a single string when you do it.
    
    // Recall that when you see "S1 += S2", you're seeing
    // S1 = S1 + S2 in an abbreviated form.  Also note that
    // the parentheses used in binding Strings together
    // are purely ornamental -- there is no order of operations
    // being usefully described there.  It is just to
    // make those operations a bit clearer to us.
    
    String startQuery = "?";
    String link = "&";
    String baseURL = "https://api.wmata.com/Bus.svc/json/jStops";
    String latQuery = "Lat=";
    String lngQuery = "Lon=";
    String radQuery = "Radius=";
    String myLat = "38.905833"; // CarBarn, 
    String myLng = "-77.069828"; // courtesy Google
    String myRad = "1000"; // how many meters-radiant to search?
    // Seriously, though:  How amazing is it that
    // I can type "Carbarn Latitude Longitude" into Google
    // and get a precise answer?  I don't even need to say "DC"
    // or "Georgetown"?  

    String geoDataQuery = startQuery;
    geoDataQuery += (latQuery + myLat);
    geoDataQuery += link;
    geoDataQuery += (lngQuery + myLng);
    geoDataQuery += link;
    geoDataQuery += (radQuery + myRad);
    
    // Now put the whole thing in one beautiful, WMATA-approved string
    String totalRequestLive = baseURL + geoDataQuery;
    
    // Here is where I ran into trouble in class on Monday.
    // Below, I use a "GetRequest."  In class, I was using
    // a "PostRequest."  GetRequests are less complicated,
    // but they are also far less secure -- I had just assumed
    // that since I needed to authenticate, they would be
    // using the safer, more robust of the two protocols.
    // They were not.  But that's good for us, because
    // it means a little less work to get the data. 
    
    // Create the GetRequest object.  Basically
    // an HTTP-friendly String of data.
    
    GetRequest myGetRequest = new GetRequest(totalRequestLive);
    
    // Hmmm.  So this was one of Monday's bugbears.  Sometimes
    // the decisions of other programmers can be vexing.  
    // The HTTPAccess protocol has a built-in authentication
    // procedure:  e.g., 
    
    // myGetRequest.addUser("user","password");
    
    // But they elected not to use that.  Instead, they want
    // the authentication data in an unmarked header.
    // Headers are essentially the metadata that accompanies
    // every webpage as it is being downloaded, or any
    // request you make online.  A header usually contains data
    // that is important to the servers in-between you
    // and your destination... It can hold our authentication
    // data, but technically it shouldn't -- there is
    // no encryption at all, and it would be very easy to 
    // grab your user credentials from a data stream like this.

    // Here's the authentication data in the format they really wanted:
    // just a simple header.
    
    myGetRequest.addHeader(apiKEY, apiVALUE);

    // Now send it to the Internet Interelves, and let's see 
    // if our wish is granted.  NOTE that Processing will
    // take as long as necessary to push the data onto the
    // onlines in this next line.  That's rare:  Most code doesn't
    // wait around for an answer, you have to build that process
    // into your program yourself.  But they've done us a favor here.
    
    myGetRequest.send();
    
    // What did we get?  What did we get?  What did we get?
    // OOoooh... its a String.  (It's always a String, pretty much.
    // The WMATA server doesn't use JSONObjects because it doesn't
    // use Processing.  So it sends a String that is easy for
    // us to convert into a JSONObject.
    
    String temp = myGetRequest.getContent();
    
    // Note that if we know what header we want, we can retrieve it here.
    // Are you saving data about the requestor?  That's in the
    // Cookie header:
    
    // String UserCookie = myGetRequest.getHeader("Cookie");
    
    // That's why the username/password header is a bit odd:  If I don't
    // know the username, I can't ask for the header.
    
    // back to my Interface Function.

    return temp;
}
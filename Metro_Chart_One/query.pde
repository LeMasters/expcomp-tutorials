String busDistanceQuery(String targetStop) {
    println("Beginning busDistanceQuery:",targetStop);

    // This function works consistent with all of the
    // other code in this project.  If you have questions
    // about anything, you should be able to find a 
    // parallel situation in the other query functions.

    String baseURL = "https://api.wmata.com/NextBusService.svc/json/jPredictions";
    String queryStart = "?";
    String busStopQuery = "StopID=";

    String myRequest = queryStart + busStopQuery + targetStop;
    String totalRequestLive = baseURL + myRequest;

    GetRequest myGetRequest = new GetRequest(totalRequestLive);

    myGetRequest.addHeader(apiKEY, apiVALUE);

    myGetRequest.send();

    String tempJSON = myGetRequest.getContent();

    // we just do this the first time through to get
    // the first chunk of data.
    
    if (initialRequestFlag==true && tempJSON != "") {
        initialRequestFlag = false;
        println("Everything checks out");
    }
    println("Finished busDistanceQuery()");

    return tempJSON;
}
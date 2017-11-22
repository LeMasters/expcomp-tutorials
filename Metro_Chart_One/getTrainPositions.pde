String trainTracker() {

    String baseURL = "https://api.wmata.com/TrainPositions/TrainPositions";

    String queryStart = "?";
    String contentAssertion = "contentType=json";

    String totalRequestLive = baseURL + queryStart + contentAssertion;

    GetRequest myGetRequest = new GetRequest(totalRequestLive);

    myGetRequest.addHeader(apiKEY, apiVALUE);

    myGetRequest.send();

    String tempJSON = myGetRequest.getContent();
    
    return tempJSON;
}
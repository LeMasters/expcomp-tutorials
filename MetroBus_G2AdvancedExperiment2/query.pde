JSONObject busRouteQuery(String routeID) {
    String baseURL = "https://api.wmata.com/Bus.svc/json/jRouteDetails";
    String queryStart = "?";
    String busRouteIDQuery = "RouteID=";
    String myRequest = queryStart + busRouteIDQuery + routeID;
    String totalRequestLive = baseURL + myRequest;

    GetRequest myGetRequest = new GetRequest(totalRequestLive);
    myGetRequest.addHeader(apiKEY, apiVALUE);
    
    myGetRequest.send();

    String tempJSON = myGetRequest.getContent();
    JSONObject busRouteShapeObj = parseJSONObject(tempJSON);
    return busRouteShapeObj;
}
String busDistanceQuery() {
    String BusJSONData = "https://api.wmata.com/NextBusService.svc/json/jPredictions";
    String myRequest = BusJSONData + "?StopID=" + myStopID;
    GetRequest get = new GetRequest(myRequest);
    get.addHeader(apiKEY,apiVALUE);
    get.send();
    String temp = get.getContent();
    return temp;
}
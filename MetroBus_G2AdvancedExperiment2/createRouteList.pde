void createRouteList() {
    String baseURL = "https://api.wmata.com/Bus.svc/json/jRoutes";
    String totalRequestLive = baseURL;

    GetRequest myGetRequest = new GetRequest(totalRequestLive);
    myGetRequest.addHeader(apiKEY, apiVALUE);

    myGetRequest.send();

    String tempJSON = myGetRequest.getContent();
    JSONObject busRouteListObj = parseJSONObject(tempJSON);
    JSONArray jsonRoutes = busRouteListObj.getJSONArray("Routes");

    for (int i = 0; i< jsonRoutes.size(); i++) {
        JSONObject data = jsonRoutes.getJSONObject(i);
        String name = data.getString("Name");
        String rid = data.getString("RouteID");
        myRouteList.add(new routeList(i, rid, name));
    }
}
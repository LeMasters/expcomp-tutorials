class MetroBus {
    String busID;
    int internalID;
    float gpsLatitude;
    float gpsLongitude;

    MetroBus(String bus, int ID) {
        busID = bus;
        internalID = ID;
        this.metroBusLocator(this.busID);
    }

    void updateMetroBus(float lon, float lat) {
        this.gpsLatitude = lat;
        this.gpsLongitude = lon;
    }

    void showMetroBus() {
        float localX = this.gpsLongitude;
        float localY = this.gpsLatitude;
        float x = map(localX, myBusRouteMap.loLongitude, myBusRouteMap.hiLongitude, leftMargin, screenAreaWidth+leftMargin);
        float y = map(localY, myBusRouteMap.loLatitude, myBusRouteMap.hiLatitude, screenAreaHeight+topMargin, topMargin);
        noStroke();
        fill(255, 0, 0);
        ellipse(x, y, 9, 9);
    }

    void metroBusLocator(String routeID) {
        String baseURL = "https://api.wmata.com/Bus.svc/json/jBusPositions?RouteID=";

        String totalRequestLive = baseURL + routeID;

        GetRequest myGetRequest = new GetRequest(totalRequestLive);
        myGetRequest.addHeader(apiKEY, apiVALUE);

        myGetRequest.send();
        String tempJSON = myGetRequest.getContent();

        JSONObject busObj = parseJSONObject(tempJSON);
        JSONArray jsonBusPosArray = busObj.getJSONArray("BusPositions");
        if (jsonBusPosArray.size()!=0) {

            JSONObject jsonBusTerminal = jsonBusPosArray.getJSONObject(0);
            float lon = jsonBusTerminal.getFloat("Lon");
            float lat = jsonBusTerminal.getFloat("Lat");
            float dev = jsonBusTerminal.getFloat("Deviation");

            this.gpsLatitude = lat;
            this.gpsLongitude = lon;
        } else {
        }
    }
}
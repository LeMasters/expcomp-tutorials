class MetroBus {
    String busID;
    int internalID;
    float gpsLatitude;
    float gpsLongitude;
    float lastUpdated;

    MetroBus(String bus, int ID, float lat, float lon, float update) {
        busID = bus;
        internalID = ID;
        gpsLatitude = lat;
        gpsLongitude = lon;
        lastUpdated = update;
    }

    void metroBusTimer(String routeID) {
        if (millis() - this.lastUpdated>(10*1000)) {
            metroBusLocator(routeID);
        }
    }

    void updateMetroBus(float lon, float lat) {
        this.gpsLatitude = lat;
        this.gpsLongitude = lon;
    }

    void showMetroBus(float nX) {
        float localX = this.gpsLongitude;
        float localY = this.gpsLatitude;
        float x = 1;// map(localX, myBusRouteMap.loLongitude, myBusRouteMap.hiLongitude, 0, myBusRouteMap.edgeRelativeRight);
        float y = 1;//map(localY, myBusRouteMap.loLatitude, myBusRouteMap.hiLatitude, myBusRouteMap.edgeRelativeBottom, 0);
        stroke(255);
        strokeWeight(4);
        fill(0,100);
        float yPlus = 1;//height*0.5*myBusRouteMap.lonLatRatio;
        float yPrime = 1;//y * myBusRouteMap.lonLatRatio;
        ellipse(x, yPlus+yPrime , 20, 20);
        this.lastUpdated = millis();
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
        JSONObject jsonBusTerminal = jsonBusPosArray.getJSONObject(0);
        float lon = jsonBusTerminal.getFloat("Lon");
        float lat = jsonBusTerminal.getFloat("Lat");
        float dev = jsonBusTerminal.getFloat("Deviation");

        this.gpsLatitude = lat;
        this.gpsLongitude = lon;
    }
}
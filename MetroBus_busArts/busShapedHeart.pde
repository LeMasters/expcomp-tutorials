class busShape { //<>//
    String routeID;
    ArrayList<busNode> gpsSites;
    float loLatitude, hiLatitude, loLongitude, hiLongitude;

    // gpsSites are nodes, route is collection

    busShape(String route) {
        gpsSites = new ArrayList<busNode>();
        routeID = route;
        JSONObject jsonBusShape = busRouteQuery(routeID);
        myScore = routeID;

        if (!jsonBusShape.isNull("Direction0")) {
            JSONObject jsonBusDirZero = jsonBusShape.getJSONObject("Direction0");
            JSONArray jsonBusArrayZero = jsonBusDirZero.getJSONArray("Shape");
            for (int i = 0; i < jsonBusArrayZero.size(); i++) {
                JSONObject jsonNodeObject = jsonBusArrayZero.getJSONObject(i);
                gpsSites.add(new busNode(jsonNodeObject));
            }
        }

        if (!jsonBusShape.isNull("Direction1")) {
            JSONObject jsonBusDirOne = jsonBusShape.getJSONObject("Direction1");
            JSONArray jsonBusArrayOne = jsonBusDirOne.getJSONArray("Shape");
            for (int i = 0; i < jsonBusArrayOne.size(); i++) {
                JSONObject jsonNodeObject = jsonBusArrayOne.getJSONObject(i);
                gpsSites.add(new busNode(jsonNodeObject));
            }
        }
    }

    void findEdges() {
        float hiLat = -900;
        float loLat = 999;
        float hiLon = -900;
        float loLon = 999;
        for (busNode node : gpsSites) {
            if (node.latitude>hiLat) {
                hiLat = node.latitude;
            } else {
                if (node.latitude<loLat) {
                    loLat = node.latitude;
                }
            }
            if (node.longitude>hiLon) {
                hiLon = node.longitude;
            } else {
                if (node.longitude<loLon) {
                    loLon = node.longitude;
                }
            }
        }
        this.loLatitude = loLat;
        this.hiLatitude = hiLat;
        this.loLongitude = loLon;
        this.hiLongitude = hiLon;
        float lonLatRatio = abs(abs(hiLon)-abs(loLon)) / abs(abs(hiLat)-abs(loLat));
        float lonElement = abs(abs(hiLon)-abs(loLon));
        float latElement = abs(abs(hiLat)-abs(loLat));
        println(lonElement, latElement, lonLatRatio);

    }

    float getLoLat() {
        return this.loLatitude;
    }

    float getHiLat() {
        return this.hiLatitude;
    }

    float getLoLon() {
        return this.loLongitude;
    }

    float getHiLon() {
        return this.hiLongitude;
    }
    
    PVector[] buildShape() {
        PVector[] shapeNodes = new PVector[gpsSites.size()];
        int i = 0;
        for (busNode node : gpsSites) {
            float localX = node.longitude;
            float localY = node.latitude;
            float x = map(localX, this.loLongitude, this.hiLongitude, edgeLeft, edgeRight);
            float y = map(localY, this.loLatitude, this.hiLatitude, edgeTop, edgeBottom);
            shapeNodes[i] = new PVector(x, y);
            i++;
        }
        return shapeNodes;
    }
}
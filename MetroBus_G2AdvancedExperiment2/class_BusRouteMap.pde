class BusRouteMap {
    String routeID;
    ArrayList<busNode> gpsSites;
    float loLatitude, hiLatitude, loLongitude, hiLongitude;
    float hRadians, vRadians;

    // gpsSites are nodes, route is collection (arrayList) of nodes

    BusRouteMap(String route) {
        gpsSites = new ArrayList<busNode>();
        routeID = route;
        JSONObject jsonBusRouteMap = busRouteQuery(routeID);
        myScore = this.routeID;

        if (!jsonBusRouteMap.isNull("Direction0")) {
            JSONObject jsonBusDirZero = jsonBusRouteMap.getJSONObject("Direction0");
            JSONArray jsonBusArrayZero = jsonBusDirZero.getJSONArray("Shape");
            for (int i = 0; i < jsonBusArrayZero.size(); i++) {
                JSONObject jsonNodeObject = jsonBusArrayZero.getJSONObject(i);
                gpsSites.add(new busNode(jsonNodeObject));
            }
        }

        if (!jsonBusRouteMap.isNull("Direction1")) {
            JSONObject jsonBusDirOne = jsonBusRouteMap.getJSONObject("Direction1");
            JSONArray jsonBusArrayOne = jsonBusDirOne.getJSONArray("Shape");
            for (int i = 0; i < jsonBusArrayOne.size(); i++) {
                JSONObject jsonNodeObject = jsonBusArrayOne.getJSONObject(i);
                gpsSites.add(new busNode(jsonNodeObject));
            }
        }
    }

    void findMapEdges() {
        float hiLat = -200;
        float loLat = 200;
        float hiLon = -200;
        float loLon = 200;
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
        this.loLatitude = 38.84;
        this.hiLatitude = 38.9955;
        this.hiLongitude = -76.90985;
        this.loLongitude = -77.119688;
        /*
         latLo 38.84;
         latHi 38.9955;
         
         lonLo -76.90985;
         lonHi -77.119688;
         */
        this.hRadians = abs(abs(hiLongitude) - abs(loLongitude));
        this.vRadians = abs(abs(hiLatitude) - abs(loLatitude));
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


    // tall/tall, wide/wide, take the lesser * tall, * wide
    PVector[] buildShape() {
        screenAreaHeight = height;
        screenAreaWidth = width;
        float rX = screenAreaWidth * this.hRadians;
        float rY = screenAreaHeight * this.vRadians;
        hMargin = 0;
        vMargin = 0;
//        println(rX, rY);
        if (rX <= rY) {
            screenAreaWidth = ((width) / rY) * rX - hMargin;
            screenAreaHeight = ((height) / rY) * rY - vMargin;
        } else {
            screenAreaWidth = ((width) / rX) * rX - hMargin;
            screenAreaHeight = ((height) / rX) * rY - vMargin;
        }
   //     println(screenAreaWidth, screenAreaHeight);
        leftMargin = (width-screenAreaWidth)*0.5;
        topMargin = (height-screenAreaHeight)*0.5;
        PVector[] shapeNodes = new PVector[gpsSites.size()];
        int i = 0;
        for (busNode node : gpsSites) {
            float localX = node.longitude;
            float localY = node.latitude;
            float x = map(localX, this.loLongitude, this.hiLongitude, leftMargin, screenAreaWidth+leftMargin);
            float y = map(localY, this.loLatitude, this.hiLatitude, screenAreaHeight+topMargin, topMargin);
            shapeNodes[i] = new PVector(x, y);
            i++;
        }
        return shapeNodes;
    }
}
void paintLandmark() {
    float[] lat;
    float[] lon;
   
    String[] DCBounds = loadStrings("DCBounds.csv");
    lat = new float[DCBounds.length];
    lon = new float[DCBounds.length];
    for (int i=0; i<DCBounds.length; i++) {
        String[] temp = splitTokens(DCBounds[i],", ");
        lat[i] = float (temp[0]);
        lon[i] = float (temp[1]);
    }
    fill(255,100);
    beginShape();
    fill(255,90);
    stroke(0,64);
    strokeWeight(2);
    for (int i=0; i<DCBounds.length; i++) {
        float localX = lon[i];
        float localY = lat[i];
        float x = map(localX, myBusRouteMap.loLongitude, myBusRouteMap.hiLongitude, leftMargin, screenAreaWidth+leftMargin);
        float y = map(localY, myBusRouteMap.loLatitude, myBusRouteMap.hiLatitude, screenAreaHeight+topMargin, topMargin);
        vertex(x,y);
    }
    endShape(CLOSE);
}
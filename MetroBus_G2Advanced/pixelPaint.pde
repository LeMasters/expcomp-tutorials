void pixelPaint(PVector[] addresses) {


    strokeCap(ROUND);
    fill(workingPalette[f]);
    background(workingPalette[b]);
    paintLandmark();   
    stroke(workingPalette[f]);
    strokeWeight(39);
    translate(75, 75);
    scale(0.825);
    for (int i=0; i<addresses.length-1; i++) {
        int realX = int(addresses[i].x);
        int realX1 = int(addresses[i+1].x);
        int realY = int(addresses[i].y);
        int realY1 = int(addresses[i+1].y);
        line(realX, realY, realX1, realY1);
    }
    stroke(workingPalette[b]);
    strokeWeight(24);   
    for (int i=0; i<addresses.length-1; i++) {
        int realX = int(addresses[i].x);
        int realX1 = int(addresses[i+1].x);
        int realY = int(addresses[i].y);
        int realY1 = int(addresses[i+1].y);
        line(realX, realY, realX1, realY1);
    }
    stroke(workingPalette[s]);
    strokeWeight(10);
    for (int i=0; i<addresses.length-1; i++) {
        int realX = int(addresses[i].x);
        int realX1 = int(addresses[i+1].x);
        int realY = int(addresses[i].y);
        int realY1 = int(addresses[i+1].y);
        line(realX, realY, realX1, realY1);
    }



    saveFrame("METRO_seriesD-#######.png");
    //  fill(workingPalette[s]);
    // noStroke();
    //myBus.showMetroBus(nX);
}
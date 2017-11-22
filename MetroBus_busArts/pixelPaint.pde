void pixelPaint(PVector[] addresses) {
    int n = int(random(14, 35))*2;
    float nX = (width*0.7)/n;
    float nY = (height*0.7)/n;

    strokeWeight(1);
    if (random(1)>0.3) {
        noStroke();
    } else {
        if (random(1)>0.5) {
            stroke(255);
        } else {
            stroke(0);
        }
    }
    fill(workingPalette[f]);
    background(workingPalette[b]);

    for (int i=0; i<addresses.length; i++) {
        float tempX = floor(addresses[i].x/nX)*nX;
        float tempY = floor(addresses[i].y/nY)*nY;
        rect(tempX, tempY, nX, nY);
    }
    fill(workingPalette[s]);
    noStroke();
    textAlign(RIGHT);
    text(myScore, width*0.9, height*0.15);

 
}
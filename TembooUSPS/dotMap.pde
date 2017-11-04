void dotTheMap() {

    // SO:  We keep adding new points on our map;
    // AND:  We keep moving the map around.
    // THUS:  We need to repeatedly draw
    // this new layer of data... otherwise
    // the map will wipe out our data layer
    // every time the screen refreshes.
    // How to do this?
    // The gist of it is this:  With every
    // new frame, we need to be ready to
    // redraw EVERY POINT we've already visited.
    // Sigh, right?
    // A-ha, BUT! We've been building our little 
    // table just for this purpose.  We just
    // need to do a quick for() loop.

    // We use a method inside the map called
    // getScreenPosition() in order to translate
    // lat and lng into screen X and Y -- which
    // is actually a lot of work when you account
    // for different kinds of map projections,
    // screen pixel densities, etc.  We'll also
    // use a class called ScreenPosition to
    // create an object (which I've called
    // myScreenPosition) in order to store
    // the X, Y data.

    // colors for my map dots


    int rowCount = dataHistoryTable.getRowCount();
    // If there are, say, 10 rows now, we'll draw 10 ellipses.
    // The placement of those ellipses will change constantly
    // as the screen moves around.  Some of them
    // will be drawn off the screen, so we won't see them.
    // But to make it easy, we'll still draw them.
    for (int rowNumber = 0; rowNumber < rowCount; rowNumber++) {
        TableRow tempRow = dataHistoryTable.getRow(rowNumber);
        float lat = tempRow.getFloat("LAT");
        float lng = tempRow.getFloat("LNG");
        String name = tempRow.getString("CITY");
        Location myLocation = new Location(lat, lng);
        ScreenPosition myScreenPosition = map.getScreenPosition(myLocation);
        // if NOT doFancyMapLabels then give us the basics.
        // OTHERWISE -- Let's rock!
        if (doFancyMapLabels == false) {
            fill(225, 60, 30);
            stroke(225, 60, 30, 64);
            strokeWeight(20); 
            ellipse(myScreenPosition.x, myScreenPosition.y, 12, 12);
            text(name, myScreenPosition.x + 12, myScreenPosition.y + 5);
        } else {
            // doFancyMapLabels
            noStroke();
            fill(0);
            String cityName = name;
            float arclength = 0;
            float myRadius = 30.0;
            int d = cityName.length();
            pushMatrix();
            translate(myScreenPosition.x, myScreenPosition.y);
            ellipse(0, 0, myRadius * 1.05, myRadius * 1.05);

            pushMatrix();
            float startPos = radians((rowNumber * 60.0)-(frameCount * 0.55));            

            for (int i = 0; i < cityName.length(); i++) {
                char currentChar = cityName.charAt(i);
                float w = textWidth(currentChar);
                float theta = startPos + (arclength / myRadius);

                pushMatrix();
                translate(myRadius * cos(theta), myRadius * sin(theta));
                rotate(theta + HALF_PI);
                text(currentChar, 0, 0);
                arclength = arclength + w;
                popMatrix();
            }
            popMatrix();
            popMatrix();
        }
    }
}
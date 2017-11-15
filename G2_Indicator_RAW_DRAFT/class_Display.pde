class Display {
    String bus;
    String units;
    int timeRemaining;
    boolean isActive;

    Display(String _bus, String _units, int theTime, boolean isOn) {
        bus = _bus;
        units = _units;
        timeRemaining = theTime;
        isActive = isOn;
    }

    void updateScreen() {
        if (this.isActive == true) {
            textFont(myType);
            noStroke();
            background(255);

            image(metroBus, 20, 20);

            // bus ID
            fill(0);
            int boxSide = 100;
            rect((width*0.9)-boxSide, boxSide*1.25, boxSide, boxSide, 8);

            fill(255);
            textSize(90);
            textAlign(LEFT);
            text(bus, (width*0.91)-boxSide, (boxSide*1.25)+(boxSide-18));


            // minutes remaining (color choice)
            if (this.timeRemaining < 5) {
                fill(220, 25, 25);
            } else {
                if (this.timeRemaining <10) {
                    fill(#FFCC33);
                } else {
                    fill(25, 230, 60);
                }
            }

            // minutes remaining (digits)
            textAlign(RIGHT);
            textSize(290);
            text(this.timeRemaining, 372, 460);
            
            // units
            fill(0);
            textSize(25);
            text(this.units, 368, 492);
            timeStamp();
            
        } else {
            background(0);
            textSize(20);
            textAlign(LEFT);

            text("Initializing", 50, height*0.85);
        }
    }
}
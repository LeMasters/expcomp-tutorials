class Display {
    String myBus;
    String myUnits;
    int timeRemaining;
    boolean isActive;

    Display(String bus, String units, int theTime, boolean isOn) {
        myBus = bus;
        myUnits = units;
        timeRemaining = theTime;
        isActive = isOn;
    }

    void updateScreen() {
        if (this.isActive == true) {
            text(myBus, 50, 50);
            text(myUnits, 50, 100);
            text(timeRemaining, 50, 150);
        } else {
            text("Not active", 50, 50);
        }
    }
}
// super simple timer

class Timer {

    int startTime;
    boolean isActive = false;
    int durationT;

    // user inputs seconds, we translate to millis()
    Timer(int temp) {
        durationT = temp * 1000;
    }

    void start() {
        if (!isActive) {
            isActive = true;
            startTime = millis();
        }
    }

    boolean clockWatcher() {
        // calculate amount of time passed
        int timePassed = millis() - startTime;

        // only finish if the clock is active and durationT passed.
        // isActive is overkill at this point.  I'll
        // revisit the matter later.

        if ((isActive==true) && (timePassed > durationT)) {

            // We're done!  Turn off the clock and I'm out.
            isActive = false;
            return true;
        } else {

            // Ugh.  This is taking forever.
            return false;
        }
    }
}
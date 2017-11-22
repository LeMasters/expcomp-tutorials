// train data

class Train{
    String trainID;
    int carCount;
    int direction;
    int circuitID;
    String destination;
    String lineCode;
    int secondsStalled;
    int dataFetched;
    
    Train(String i, int c, int d, int id, String dest, String _lc, int stall, int age) {
        trainID = i;
        carCount = c;
        direction = d;
        circuitID = id;
        destination = dest;
        lineCode = _lc;
        secondsStalled = stall;
        dataFetched = age;
    }
}
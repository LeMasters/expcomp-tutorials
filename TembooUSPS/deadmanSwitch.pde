void deadmanSwitch() {

    // failsafe -- too many Temboo
    // queries will shut our access down.
    
    if (frameCount>(failSafe * framesBetwixt)) {
        // randomize serial number
        int n = int(random(1000, 9999));
        String fileName = "DataHistory_" + str(n) + ".csv";
        saveTable(dataHistoryTable, fileName);
        println("Data saved as", fileName);
        noLoop();
        exit();
    }
}
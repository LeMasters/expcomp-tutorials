class busNode {
    int nodeID;
    float latitude;
    float longitude;
    int seqNumber;

    busNode(JSONObject node) {
        latitude = node.getFloat("Lat");
        longitude = node.getFloat("Lon");
        seqNumber = node.getInt("SeqNum");
        nodeID = millis();
    }

}
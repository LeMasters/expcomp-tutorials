class busNode {
    float longitude;
    float latitude;
    int seqNumber;

    busNode(JSONObject node) {
        longitude = node.getFloat("Lon");
        latitude = node.getFloat("Lat");
        seqNumber = node.getInt("SeqNum");
    }
}

class routeList{
    int indexID;
    String routeID;
    String name;
    
    routeList(int i, String r, String n) {
        indexID = i;
        routeID = r;
        name = n;
    }
}
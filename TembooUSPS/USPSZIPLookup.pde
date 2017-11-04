Location USPSZIPLookup(String ZIPresearch) {
    
    // Look for our ZIPresearch String (e.g., "20057")
    // in the "ZIP" column of the ZIPCodeTable.
    // When you find it, copy the whole row out
    // into a stand-alone row called myZIPRow.
    // That row is just a temporary, disposable row.
    
    TableRow myZIPRow = ZIPCodeTable.findRow(ZIPresearch, "ZIP");
    float latitude = myZIPRow.getFloat("LAT");
    float longitude = myZIPRow.getFloat("LNG");
    
    Location myResponse = new Location(latitude, longitude);
    return myResponse;
}
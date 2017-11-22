int trainPositionParser(JSONObject JSONTrainObj) {
    JSONArray jsonPositionArray = JSONTrainObj.getJSONArray("TrainPositions");
    
    // Are we of significant size?  Loop through each train, then.
    // i works here as a record number or a unique key (that does not
    // necessarily correspond to any unique key assigned by WMATA).
    if (jsonPositionArray.size()>0) {
        for (int i = 0; i < jsonPositionArray.size(); i++) {
            JSONObject JSONTrain = jsonPositionArray.getJSONObject(i);

            // We're there.  Identify the specific KEYs and get the VALUEs:
            String stationCode = JSONTrain.getString("DestinationStationCode");
            String serviceType = JSONTrain.getString("ServiceType");
            String trainID = JSONTrain.getString("TrainId");
            String lineCode = JSONTrain.getString("LineCode");
            int carCount = JSONTrain.getInt("CarCount");
            int direction = JSONTrain.getInt("DirectionNum");
            int stalled = JSONTrain.getInt("SecondsAtLocations");
            int circuit = JSONTrain.getInt("CircuitId");
            
            // Fill in our own JSONObject
            
            
        return WMATAPrediction;
    } else {
        return -1;
    }
}
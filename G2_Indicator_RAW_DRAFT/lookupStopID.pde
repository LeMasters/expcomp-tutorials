void lookupStopID() {
    // this routine will probably just run
    // one time -- during the first loop of the
    // draw() function.

    // Huzzah!  We start by calling stopQuery
    // and assigning the returned value -- a String --
    // to a temporary String.  

    String temporaryResponse = busStopIDQuery();

    // We parseJSONObject
    // to transform that seemingly innocent String into 
    // the creature that it has always been:
    // a terrible JSONObject.  

    JSONObject myBusStopJSONObject = parseJSONObject(temporaryResponse);

    // Now that it is
    // revealed in its True Form, we may procede:
    // Create a JSONArray, and grab the only array
    // inside the JSONObject -- the one called "Stops".

    JSONArray myBusStopArray = myBusStopJSONObject.getJSONArray("Stops");

    // NOW our array has only one element, because
    // there is only one bus stop at the location
    // we asked for ...  but if there were more,
    // this is where you'd start looping through
    // each of them and collecting the data you need.

    // for us, we just need to grab some data from [0]:

    JSONObject tempJSON = myBusStopArray.getJSONObject(0);
    myStopID = tempJSON.getString("StopID");

    // We could grab the latitude and longitude, but
    // we already have those; Additionally, we already
    // have the Route names (G2, G2cv1).  So we're done.
    // now we have what we need:  the StopID of the G2:
}
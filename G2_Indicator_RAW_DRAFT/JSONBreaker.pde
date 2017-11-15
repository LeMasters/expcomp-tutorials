// here's what gets returned when we look for a station ID
// {"Stops": <--- KEY is 'Stops', but instead of getting ONE VALUE...
//     [   <-- we get an ARRAY bracket, meaning MANY parallel VALUES 
//
//        And each element of that array is itself an OBJECT
//        In this case, an object called... a STOP.
//        It has many qualities:  an ID, a name, Lon, Lat...
//        To hold the OBJECT together, it is enclosed in
//        Curly braces... but then it is just lots of Key:Value pairs.
//
//        {"StopID":"1001345",
//         "Name":"PROSPECT ST NW + 36TH ST NW",
//         "Lon":-77.069828,
//         "Lat":38.905833,
//         "Routes": <-- same as above, but in our STOP object...
//                    Now we see another bracket, meaning that
//                    what could have been a single value
//                    will instead be 1 or more parallel values.
//                    [
//                        "G2",
//                        "G2cv1"
//                     ]
//         }
//     ] <-- notice that we close the array but only had a single element
//            (i.e., one STOP object).  What gives?
//            Arrays can have 0, 1, or more elements... all are valid.
//            If I ask WMATA for a non-existent bus stop, for example,
//            here's what it will say to me:
//            {"Stops":[]}
//            The empty brackets mean an empty set / an empty array.
// }


// Note that we will need to return number of minutes as an integer.

int JSONBreaker(JSONObject JSONBusObj) {
    JSONArray jsonPredictionDataArray = JSONBusObj.getJSONArray("Predictions");
    if (jsonPredictionDataArray.size()>0) {
        JSONObject JSONAnswer = jsonPredictionDataArray.getJSONObject(0);

        // We're there.  Identify the specific KEY and get the VALUE:
        int WMATAPrediction = JSONAnswer.getInt("Minutes");
        return WMATAPrediction;
    } else {
        return -1;
    }
}
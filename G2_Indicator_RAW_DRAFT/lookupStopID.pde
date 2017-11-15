void lookupStopID() {
    // this routine will probably just run
    // one time -- during the first loop of the
    // draw() function.

    // this function is what I call an Interface Function --
    // I use functions like this to sit between my main
    // draw() loop and the functions that do the real
    // work (in this case, busStopIDQuery()).  If
    // I were to rewrite this code starting from what
    // I have done here, I'd probably eliminate this function,
    // as it isn't really necessary.  But when I'm writing
    // code from scratch, I use an interface function like
    // this to give me room to think about how the 
    // control of the program should flow.
    // As it is, the five or six lines of code in this
    // function send the StopID to WMATA, and get
    // back a String response.  We parse that to
    // a JSONObject, pull a JSONArray out of that, 
    // and then grab the two or three
    // lines of data that matter.

    // Note that you don't really have to convert the
    // String to a JSONObject.  If you're having trouble
    // with JSON, you can just leave the string as a 
    // String and then split() the string a couple of
    // times... It isn't pretty, but I always spend
    // four times longer on JSON than I should, and if
    // I weren't writing this code for you to read, I
    // might be tempted to take the shortcut.
    //
    // Always remember, though:  The shortcut will only
    // work today.  There's always a good chance that
    // something will change tomorrow, and your code
    // will break.  That's why JSON is a better choice here.


    // Huzzah!  We start by calling stopQuery()
    // and assigning the returned value -- a String --
    // to a temporary String.  

    String temporaryResponse = busStopIDQuery();
    
    // Now we've caught that String from the
    // busStopIDQuery() function!  Let's get to work.
    
    // Most of the code from this point in the function
    // is dedicated to pulling the data we need from 
    // the JSON file.  If we were doing multiple
    // stops, then we'd probably be using a StopID
    // array.  So we'd loop through this as often
    // as necessary to process each of the JSONObjects
    // in turn.

    // We parseJSONObject
    // to transform that seemingly innocent String into 
    // the creature that it has always been:
    // a terrible, terrible JSONObject.  

    JSONObject myBusStopJSONObject = parseJSONObject(temporaryResponse);

    // Now that it is
    // revealed in its True Form, we may procede:
    // Create a JSONArray, and grab the only array
    // inside the JSONObject -- the one called "Stops".
    // (Remember that "Stops" is the first KEY, and then
    // instead of a single value, there is an opening
    // bracket, indicating an array is coming...)

    JSONArray myBusStopArray = myBusStopJSONObject.getJSONArray("Stops");

    // NOW our array has only one element, because
    // there is only one bus stop at the location
    // we asked for ...  but if there were more,
    // this is where you'd start looping through
    // each of them and collecting the data you need.

    // But for now, just grab some data from [0]:
    
    // This is always one of the places where I get tripped
    // up on JSON:  array.getJSONObject() takes an integer
    // as its argument, to indicate (in this case) that
    // it should grab the first JSONObject (the 0th).
    // I usually end up trying to put a String in that
    // argument for some reason, as though the object
    // had a name.  It doesn't.  But that is one of the 
    // errors I inevitably have to address.

    JSONObject tempJSON = myBusStopArray.getJSONObject(0);
    
    // We grab the stopID here.  We came with a
    // latitude and longitude and a search radius,
    // and we're leaving with a single stopID.  
    // NOTE that if we wanted to use this for more
    // than one stop, we'd probably convert 
    // myStopID to an array, myStopID[].
    
    myStopID = tempJSON.getString("StopID");

    // We could grab the latitude and longitude, but
    // we already have those; Additionally, we already
    // have the Route names (G2, G2cv1).  So we're done.
    // now we have what we need:  the StopID of the G2:

    // artificially insert library stop
    myStopID = "1001370";
    println("myStopID identified:",myStopID);
}
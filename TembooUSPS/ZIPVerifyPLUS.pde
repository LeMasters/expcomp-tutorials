int runCityStateLookupChoreo(String myZIPQuery) {
    
    int rowID = 0;
    
    // this code was originally included with
    // the Temboo library, but I have rewritten
    // almost all of it.
    

    // Now tempZIP is our unproven ZIP code.  So we
    // should code with care here, taking into account the
    // real possibility that we won't always get the kind
    // of response we want.  This is called "error handling."

    // Kick things off by passing our TembooSession
    // (which I created as "mySession")
    // to the Temboo-built function CityStateLookup.
    // By doing that, we'll be creating an object called
    // a cityStateLookupChoreo -- built from the CityStateLookup
    // class.  Does that seem overly complicated?  Oh my god yes.
    // It is needlessly bloated.  Honestly, it is probably
    // easier to just use the USPS API by itself, without Temboo.
    // HOWEVER, while Temboo is needlessly complicated, it is 
    // CONSISTENTLY complicated, which means that it is very
    // easy to move from USPS APIs to GOOGLE APIs to 
    // FEDEX APIs and keep most of your code the same.
    // Its a tradeoff.

    // Let's take a look at this line:

    // CityStateLookup cityStateLookupChoreo = new CityStateLookup(mySession);

    // It's a fairly typical statement that calls 
    // a new object into being by passing an argument to the Class.
    // Yes, it is a bit... awkward looking, but let's
    // give it a shot.

    // CityStateLookup is a CLASS -- an ARCHETYPE
    // cityStateLookupChoreo is the name we're giving
    // to a new OBJECT, built from the CityStateLookup blueprints.
    // To fill that new Object with data, we'll call the 
    // constructor inside the CityStateLookup class, and pass 
    // the session (with my ID info) into the constructor.

    // Ugh, I know.  Try this instead:

    // Skyscraper EmpireState = new Skyscraper("New York City");
    // OR
    // MovieIcon HarrisonFord = new MovieIcon("Star Wars", "Blade Runner");
    // OR
    // AncientGod Hermes = new AncientGod("Greece", "Apollo", "Lyre", "Mercury");
    // AncientGod Monkey = new AncientGod("China", "Xuanzang", "Staff", "Hanuman");

    CityStateLookup cityStateLookupChoreo = new CityStateLookup(mySession);

    // now that we've created our object, we'll fill it with more
    // data by calling some of its methods (its "functions.")
    // In this case, we're calling "setters" which (surprise!)
    // set values inside the object.
    // 

    String USPSID="405GEORG5918";
    String USPSPass="998OZ92EF503";
    cityStateLookupChoreo.setZip(myZIPQuery);
    cityStateLookupChoreo.setUserId(USPSID);
    cityStateLookupChoreo.setPassword(USPSPass);

    // Run the Choreo and store the results

    // FINALLY, we're ready to submit the query to the Postmaster General.
    //
    // The line below suffers from terrible variable names.  Let me try to 
    // make it clearer.  (It looks a bit like code that would create a new object,
    // but it is not, by the way).

    CityStateLookupResultSet cityStateLookupResults = cityStateLookupChoreo.run();
    // 
    // So ugly.  But this set of instructions is essentially the same:
    // DataCollection myPlaylistBackups = iTunesLibrary.backup();

    // What does cityStateLookupChoreo.run() mean?
    // It is a method() (a function()) that opens up a port and sends all the data it has
    // collected to Temboo servers.  
    // One thing to remember:  Those parentheses almost never appear
    // attached to variables -- they are typically
    // indicative of methods/functions:
    // distance.run; // could be a variable
    // distance.run(); // 99% likely a function or method.

    // Now some gymnastics!
    // Take the response from the Temboo server,
    // (it comes to us as a String),
    // turn it into an XML file, and then extract content as necessary.
    // (I'm using XML here, but could also use JSON)

    // 
    String USPSInfo = cityStateLookupResults.getResponse();
    XML myXML = parseXML(USPSInfo);

    // Now I save the file, just because I can.
    // Can be useful for long-term data collection.
    // You aren't obliged to do that.

    saveXML(myXML, "postoffice_info.xml");
    // That part is so easy!
    // Now we read data from specific parts of the myXML object.
    // We only know the structure of the file by poking around, usually
    // by hand.

    // Identify the parts of the xml file that we're interested in.

    XML cityInfo = myXML.getChild("ZipCode/City");

    // if an answer comes back, then it worked.  If we
    // get no answer (null) then we'll send "false"
    // back to the function that originally called us.

    if (cityInfo!=null) {
        // we got some data! go ahead and decode the state, too
        XML stateInfo = myXML.getChild("ZipCode/State");
        // before we save this data, change it from XML to String
        String theCity = cityInfo.getContent();
        String theState = stateInfo.getContent();
        
        // now store it in our data table.
        // Since we haven't started our new row yet,
        // we need to do that now.  Start with a
        // generic, empty row that has all the
        // same columns by default as our
        // dataHistoryTable.
        TableRow myNewRow = dataHistoryTable.addRow();

        // our new row gets a new ID
        // for unique identification.  
        // For us, it happens also to be a number
        // that indicates the order in which things happened.
        
        // Here's the very important number we are going to 
        // send back to the function that called us -- and
        // that function will send back to the function that
        // called it.  The row number of our latest 
        // dataset addition.
        
        rowID = dataHistoryTable.lastRowIndex();
        // note that for the moment, that row is completely
        // empty...
        myNewRow.setInt("ID", rowID);
        // In addition to that ID number,
        // insert zipcode we brought with us
        // from the previous function.
        myNewRow.setString("ZIP", myZIPQuery);
        myNewRow.setString("CITY", theCity);
        myNewRow.setString("STATE", theState);
        
        // Wunderbar!  Now we need to consult the USPS'
        // table (originally a .CSV file) and recover
        // the relevant latitude and longitude... I
        // built a little function for this very purpose!
        Location myNewLocation = USPSZIPLookup(myZIPQuery);
        
        // And we're back!  myNewLocation now holds the lat
        // and the lng of the zipcode, thanks to the
        // folks from the US Postal Service.
        // Amor vincit omnia!
        // So we'll jam those numbers into our new table.
        // These are methods particular to the Location class.
        // Next week, we'll look at how to use a library's
        // JavaDocs -- standardized reference manuals.
        
        // NB UnfoldingMaps uses "Lon" for longitude,
        // where I've been using "Lng".  I'd
        // change mine to make it a bit less confusing,
        // but it would inevitably break something
        // at this point, so we'll live with it.
        
        float latitude = myNewLocation.getLat();
        float longitude = myNewLocation.getLon();
        myNewRow.setFloat("LAT",latitude);
        myNewRow.setFloat("LNG",longitude);        
    }
    return rowID;
}
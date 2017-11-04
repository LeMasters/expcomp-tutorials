
void getEcoDataByZip(String myZIP) {
    
    // Create the Choreo object using the Temboo session
    // that we set up early in the program.
    // Note that "EcoByZip()" is actually
    // the name of one of their classes.
    // So we can't change it willy-nilly.
    // You can typically change the name of
    // objects, as long as you're consistent.
    // But classes -- especially classes that
    // other people have built -- are more
    // fragile, so typically we leave them alone.
    
    EcoByZip ecoChoreo = new EcoByZip(mySession);
    
    // Now go build my credentials from supplied JSON data
    // but turn it into a String so I can send it
    // to their servers.
    String myGenabilityCredentials = genabilityJSON();

    // Here we load up the ecoChoreo object
    // (built from the EcoByZip class) with
    // our 2 data chunks:  A ZIP code that
    // we know to be 100% legit, and 
    // my API credentials for one of the
    // servers it is about to query.
    
    ecoChoreo.setZip(myZIP);
    ecoChoreo.setAPICredentials(myGenabilityCredentials);

    // The only thing left to do?  Hug
    // it tight -- hold it close -- and
    // remind it that it will always be
    // your favorite dataset, no matter
    // what happens.  Then -- then! --
    // let it go!  Let it live, laugh, love!

    // Oh, also, we need to use this annoying format
    // to catch the data when it comes back because
    // there are many different APIs running in 
    // the background, and Temboo has built
    // this class to cradle that data gently, dear reader.
    // Very, very gently.
    
    // eco.Choreo.run() is what actually starts the
    // process.  It doesn't return any information,
    // it just stores it internally in a big JSONObject.
    EcoByZipResultSet ecoByZipResults = ecoChoreo.run();

    // Which is why we have to look at it this way.
    //println(ecoByZipResults.getResponse());
}
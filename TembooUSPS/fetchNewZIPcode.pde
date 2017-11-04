int findMeSomethingNew() {
    
    // the int referred to above
    // is going to become the row number
    // we've just added to our table.
    
    // So...
    // pick a random number between 0 
    // and number of rows of data in our table
    int n = int(random(ZIPCodeTable.getRowCount()));

    // now we extract that row so we can work on it.
    // stored in a type of variable called a 
    // TableRow.  TableRow is one line from an
    // excel spreadsheet.  1 row, many columns.
    TableRow myZIPRow = ZIPCodeTable.getRow(n);

    // get String of data from column called "ZIP"
    String retrievedZIPCode = myZIPRow.getString("ZIP");

    int rowID = runCityStateLookupChoreo(retrievedZIPCode);
    
    // runCityStateLookupChoreo(zip) is a function
    // that comes with Temboo -- I've edited it
    // in order to get it to do the things I want it
    // to do.  But that's my choice -- one of the
    // advantages of using something like Temboo
    // is that it can save you days, even weeks,
    // of time you'd otherwise spend writing,
    // debugging, and rewriting code.
    return rowID;
}
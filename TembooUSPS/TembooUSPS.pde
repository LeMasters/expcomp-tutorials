// Garrison LeMasters 2017 Georgetown CCT //<>// //<>//
//
// November 2017
// This code demonstrates the use of Temboo-built
// API wrappers to fetch USPS-sponsored data.
// Passes verified ZIP codes to various other
// APIs using Temboo's "chaining" feature.
// These return environmentally-significant
// data for any given ZIP, including
// electricity rates, nearby hazardous wastes,
// nearby chemical production, and then
// (because why not?) we get the day's
// UV forecast from the US Weather Service.

// reminder:  
// In this system,
// Lat is Y, Lng is X; 
// Order is commonly Lat, Lng
// e.g., midwest US includes coordinates 43.3,-115.05

// Libraries!
// The UnfoldingMap library is German, but much
// of the documentation is available in English

import com.temboo.core.*;
import com.temboo.Library.USPS.AddressInformationAPI.*;
import com.temboo.Library.Labs.GoodCitizen.*;

import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
// import de.fhpotsdam.unfolding.providers.StamenMapProvider;


// Note that I'm using only a
// handful of globals here (admittedly,
// the number is constantly changing as
// I work to debug the code).
// That's a good goal -- but (as always)
// think of this as a an intellectual
// challenge rather than a computational
// imperative.

// With the exception of the Table,
// the globals I'm calling on here are all
// particular to the libraries I'm using.
// They are "types" -- like int, float, String --
// that are really just objects.  A String,
// as it happens, is really an object as well.
// In sum, declaring a variable is the same
// the first step in creating an object from a class.
// e.g.,
// Zombie myZombie; // class object (recipe, single cookie)
// 
// The first global below is a Table.
// a TABLE is exactly what it sounds like.  We can load
// .csv files directly into it, preformatted and perfect,
// and then we can do searches in specific rows or columns
// to find the data we need.  Tables are everything
// that is great about America!  USA!  USA!

int failSafe;
int framesBetwixt;
Table ZIPCodeTable;
Table dataHistoryTable;
UnfoldingMap map;
TembooSession mySession;
Location currentLocation;
Location nextLocation;
Location defaultLocation;
PFont myFont;
boolean doFancyMapLabels;

void setup() {
    // important to use the P2D renderer with this version of
    // UnfoldingMap's API.  

    size(800, 600,P2D );
    smooth(8);
    
    // How many seconds between each new city?
    int secondsBetween = 4;
    
    framesBetwixt = 60 * secondsBetween;
    
    // Stop after this many cities, no matter what.
    // A failsafe to avoid using up Temboo's allowed
    // API queries.
    failSafe = 14;

    myFont = createFont("AvenirNext-Bold", 16);
    textFont(myFont, 16);
    doFancyMapLabels = true;

    // these IDs are temporary; 
    // if you can, please use your own.
    String tembooID = "dszsDbk6VwXlltjnF92XrYvfgpBxvBeP"; 
    String userID = "expcomp";
    String app = "expComp";

    // A "session" is an event that begins with you logging into
    // temboo, identifying yourself, and then requesting 
    // data through specific "choreos" (I have no idea what that word
    // means, but it sings with the voice of an Angel.)
    //
    // We can make sense of this via our recent conversation
    // regarding Object Oriented Programming.
    // Like a lot of the code you'll work with in the decade to come,
    // the code provided by Temboo is mostly a collection
    // of Classes that can generate Objects for you.

    // mySession is the Object in this case; 
    // it was "constructed" out of the
    // Class called TembooSession.  
    // TembooSession -- the Class -- is the blueprint, 
    // the recipe, the archetype.  You never see it on your
    // screen, but it is always busy behind the scenes.
    // Contrariwise, the Object mySession
    // is the single chocolate chip cookie, 
    // the idiosyncratic house on 34th and Volta, 
    // that creepy guy named
    // Chad who won't stop texting you.

    // Class:Object :: General:Particular

    // setup our Temboo session (we'll use it a few times)
    mySession = new TembooSession(userID, app, tembooID);

    // setup map stuff (the UnfoldingMap library)
    // a Location is a class that they have built
    // into their library.  It is (as far as I
    // can tell) just a latitude and a longitude,
    // packed into one container.  
    //
    // In fact, if you look at the next line, 
    // following these comments, it is a
    // classic call to the Class' constructor --
    // a call to build a new object.  (The
    // word "new" is almost always the giveaway, here.)

    // Way up near the top of this page, we'd already declared:
    // Location defaultLocation;
    // Location is a new "type" of variable.
    // Once that's finished, we just need to call the
    // constructor inside the class.
    defaultLocation = new Location(43.3, -115.05);

    nextLocation = defaultLocation;
    currentLocation = defaultLocation;

    // "this", used in the next line, is the way
    // code can refer to itself.  Don't worry
    // about it for now.
    map = new UnfoldingMap(this);
    // NICE OPTION:  new StamenMapProvider.WaterColor();
    // Don't forget to add Stamen to the library imports.
    map.setTweening(true);
    map.zoomAndPanTo(defaultLocation, 7);
    MapUtils.createDefaultEventDispatcher(this, map);

    // Last phase of our setup():
    // put our PostOffice CSV with zipcodes
    // latitudes and longitudes
    // into a table. Use the word "header" when
    // there is a header to account for...
    ZIPCodeTable = loadTable("zipcode_data.csv", "header");

    // finally, let's create a table where
    // we'll store a history of the data we use.

    dataHistoryTable = new Table();
    dataHistoryTable.addColumn("ID");
    dataHistoryTable.addColumn("ZIP");
    dataHistoryTable.addColumn("CITY");
    dataHistoryTable.addColumn("STATE");
    dataHistoryTable.addColumn("LAT");
    dataHistoryTable.addColumn("LNG");
}

// now to the draw loop.

void draw() {

    //background(0);

    // map.draw() calls the a method
    // internal to the UnfoldingMap class --
    // of which map is an object.
    // (remember above, when they said
    // UnfoldingMap map;
    // That is what created this map object.

    // The draw() method inside that class
    // puts our object on the screen for us.
    // (UnfoldingMap.draw() is not the same as
    // our more familiar use of void draw().
    // They are totally distinct.

    map.draw(); 

    // remember that we keep cycling through this function;
    // If we want to do anything new -- that is, identify
    // a new point on the map, a new zipcode, etc. -- it'll 
    // probably have to start from here.  
    // So every thirty seconds
    // or so, this conditional will fire, and we'll 
    // be able to move to a new place.
    // 
    // (if frameCount is a multiple of 1000, then do this:)
    if (frameCount%framesBetwixt == 0) {

        // since we're using our own table to 
        // track the history of where we've been,
        // and since a table row has lots of different
        // information stored inside, I'm going
        // to take advantage of this.  Instead
        // of passing back actual data, I'm just
        // going to build findMeSomethingNew() so that
        // it returns an integer -- an integer
        // which, in turn, points to the newest
        // row of data in our table...  

        int rowID = findMeSomethingNew();

        // Now I'll use that rowID and fetch all
        // the data I need.

        TableRow tempRow = dataHistoryTable.getRow(rowID);
        float lat = tempRow.getFloat("LAT");
        float lng = tempRow.getFloat("LNG");
        nextLocation = new Location(lat, lng);

        // map.panTo(nextLocation) tells the library
        // to start panning to the next location.
        // I only have to call it once -- it flips
        // a swtich and the camera moves from
        // point a to point b, then stops automatically.
        map.panTo(nextLocation);
        currentLocation = nextLocation;
    }

    // Finally, a function I built to put
    // labels on the map.
    dotTheMap();
    deadmanSwitch();
}
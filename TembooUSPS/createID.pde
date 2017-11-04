// builds the JSON string for my genability authorization
// returns JSON object

// Note that this is not the way to handle security.
// Ever.  I'm doing it this way so that you how the
// JSON authentication data is formed, and where
// it goes.
// But it merits repeating:  Do not put
// IDs passwords etc. in code that is publicly
// legible.

/*
Here is the JSON data structure that
this code builds for us (beginning
from the first curly brace, below).

{    
    "Genability": {
        "AppID": "53b789be-023c-4e54-a40b-a33451ff5986",
        "AppKey": "4f3b9822-d3a4-428e-b8b2-c791466d413e"
    }
}

The APP ID and the Key are K:V pairs
(Key:Value pairs), which we've touched on in class.
The Keys are AppID and AppKey in this case.  We are obliged 
to ensure that they are unique -- that they are not repeated
elsewhere -- as that would defeat their purpose.
After the key and a colon comes the value -- in this
case, a long string.

These two values -- which are seperated by a comma -- are then
wrapped up in a delicious "data burrito":  That pair of
K:V pairs becomes the VALUE to the top-level key, Genability.
The two lines inside the data burrito appear as a single
value because they are enclosed inside a pair of curly braces
(a soft digital corn tortilla).  I think the code
below makes the process fairly clear.  Note that I build the
insides first (the second level), and then jam it into the
first level.  The next to last line of code creates a JSON
object that has "Genability" as its Key and then both
lines from levelTwo as its Value.

Finally, I return this as a String so that I can
submit it with the rest of my query.
*/

String genabilityJSON() {
    String appID = "53b789be-023c-4e54-a40b-a33451ff5986";
    String appkey = "4f3b9822-d3a4-428e-b8b2-c791466d413e";
    JSONObject levelOne = new JSONObject();
    JSONObject levelTwo = new JSONObject();
    levelTwo.setString("AppID","53b789be-023c-4e54-a40b-a33451ff5986");
    levelTwo.setString("AppKey","4f3b9822-d3a4-428e-b8b2-c791466d413e");
    levelOne.setJSONObject("Genability", levelTwo);
    String auth = levelOne.toString();
    return auth;
}
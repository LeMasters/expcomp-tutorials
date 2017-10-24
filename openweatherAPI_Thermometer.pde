//simple openweatherapi experiment
// glemasters 2017 georgetown

// NOTE THAT YOU MUST ADD YOUR openweatherAPI
// KEY before this will work.

// Obviously incomplete, but illustrates
// the principle.

int thermTop, thermBottom;
int thermWidth;
String url;
float displayTemp;
boolean gotWeather;
float temperature;

void setup() {
  size(480, 720);
  smooth();
  thermTop = 50;
  thermBottom = height-50;
  thermWidth = 50;
  String CityID = "4140963";
  gotWeather = false;
  temperature = 0;
  // registered for free acct 22 October 2017
  String myKey = "YOUR KEY GOES HERE";
  String baseURL = "http://api.openweathermap.org/data/2.5/";

  // one of the problems today:  The documentation is apparently
  // out of date; using this query ("weather?") is now the recommended
  // approach.
  String baseQuery = "weather?id=";

  // interesting side note:  by DEFAULT, openweathermap's API
  // delivers your temperatures in units Kelvin.  Kelvin.
  // Seriously?

  // Also: Change the qualifier below to "&units=metric" if
  // prefer to quantify things base-10.

  String unitsQualifier = "&units=imperial";
  String baseAPI = "&APPID=";

  // Now... Let's put the whole thing together

  url = baseURL + baseQuery + CityID + unitsQualifier + baseAPI + myKey;

  // to keep things simple, I'll stop the program immediately
  // after I display the data.  I'd built a little timer to
  // regulate the check frequency, but that confuses things for now.
  displayTemp = 0;
}

void draw() {
  background(128);
  if (gotWeather == false) {
    temperature = 60;
   // temperature = getWeather();
  }
  float delta = abs(displayTemp-temperature)*0.02;
  showThermometer(displayTemp);
  if (displayTemp<temperature) {
    displayTemp = displayTemp + delta;
  } else {
    if (displayTemp>temperature) {
      displayTemp = displayTemp - delta;
    }
  }
}

void showThermometer(float temp) {
  fill(255);
  stroke(0);
  strokeWeight(15);
  float mercury = thermWidth - 13;

  // margin to the left and right
  float margin = (width - thermWidth) * 0.5;

  // height of thermometer is the yposition 
  // at bottom MINUS the space at the top
  int thermHeight = thermBottom - thermTop;

  // draw an outline
  // start upper left hand corner:
  // margin X, top of the thermometer Y
  // then extend across the thermWidth
  // and down the thermHeight.
  

  rect(margin, thermTop, thermWidth, thermHeight, 15);
    fill(255, 25, 25);
  ellipse(width/2,thermHeight+thermTop-(thermWidth*0.45),thermWidth*1.25,thermWidth*1.25);

  // Now:  Where will our "mercury" begin (at base) and end?
  // It begins at the same place the thermometer itself
  // begins:  thermBottom (remember:  thermBottom is a
  // screen Y address, while thermHeight is a height
  // that isn't bound to any particular place on the screen).
  // (Those are my arbitrary conventions).

  // So: 
  // we need to take our temperature and map() it to the
  // placement of our thermometer.  Note that it is
  // unusually tricky here:  We want the mercury to rise
  // from the base of the screen, not fall from the top.

  float tempFinalY = map(temp, -15, 110, 2,thermHeight);

  // NB that I use the negative of tempFinalY -- I need
  // to push the other end of the rectangle upwards -- 
  // so I'm moving from positive to negative range of numbers.
  // A rectangle that is -50 pixels tall is perfectly fine --
  // it just extends UP from the corner, rather than DOWN.
  
  fill(255, 25, 25);
  noStroke();
  rect(margin + 7, thermBottom, mercury, -tempFinalY,11);

  // mercury shading
  fill(255,66);
  rect(margin + (mercury*0.75), thermBottom-5, mercury*0.25, -tempFinalY+18,80);
  
  // final shading on glass
  fill(0,64);
  rect(margin + 6, thermBottom, thermWidth * 0.25, -thermHeight+25,11);

 // rect(margin*1.1, thermTop*1.1, thermWidth*0.7, thermHeight*0.975, 50);
}


float getWeather() {

  // This is the same code (I think) we used this
  // morning; the difference is that we didn't use
  // "weather" as the query in the URL -- I used
  // "forecast," which in some cases is deprecated.


  // here, we drill down into the section "main"
  // and then retrieve the "temp" -- a floating
  // point number.
  gotWeather = true;
  JSONObject json = loadJSONObject(url);
  JSONObject myMain = json.getJSONObject("main");
  float weatherTemp = myMain.getFloat("temp");
  println(weatherTemp);
  return weatherTemp;
}

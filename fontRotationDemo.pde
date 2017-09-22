// glemasters demo
// makes use of PFont -- onscreen typography
// sept 22 2017

color blu1, blu2, blu3, red1;
PFont myFont;
float myFontSize;
float myRadius;
float myRotation;
float rotationAdj; // adjust rotation


void setup() {
	size(500,800);
	smooth(8);
  
	myFontSize = 22;
	myFont = createFont("Georgia-Bold", 22);
	textFont(myFont, myFontSize);
  
	frameRate(5); // slow this train down!
	// again, by default, it is set at 
	// frameRate(60);
  
	myRotation = 0;
	myRadius = 180;
	rotationAdj = 6;
	// we'll want this to go neatly into 360
	// (try 13 to see why...);

	red1 = color(#F03570);
	blu1 = color(#C5D4CA);
	blu2 = color(#F0EAD2);
	blu3 = color(#0A1A27);
	background(blu3);
	noStroke();
}

// we'll depend on this 
// draw() function to keep looping
// all the around one time!

void draw() {

	translate(width*0.25, height*0.6);
	rotate(radians(myRotation));
	
	// myRadius is constant here
	// (180) -- we could've lived
	// without a variable.
	translate(myRadius, 0);

	 fill(blu1);
	 text("£0V€",0,0);

	// to see more about how the text
	// function works, try un-commenting
	// the following 2 lines.
	//	fill(red1);
	//	text("<3",75,0);
	
	// now move us further around the circle
	myRotation = myRotation + rotationAdj;

	// now check:
	if(myRotation>358) {
		// have we gone all the way around?
		// if yes then stop!
		noLoop();
		// but if no, we'll do it all over again!
	}
}

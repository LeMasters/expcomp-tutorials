// glemasters 2017 CCT Georgetown
// orbital rotations along diverse axes


// global variables

// Note that since all of the stellar bodies
// share certain qualities, I've made their
// variables share similar names.  The digit
// on the end 
// (ex:  name0, name1, name2)
// allows me to distinguish between
// them, but it really isn't a good system:
// It is too easy to misread the variable name
// and think the number serves a different
// role.  We'll solve that problem next week.

float pos0,pos1,pos2,pos3,pos4,pos5;
String name0, name1, name2, name3, name4, name5;
float orbit0, orbit1, orbit2, orbit3, orbit4, orbit5;
float dia0, dia1, dia2, dia3, dia4,dia5;
float vel0, vel1, vel2, vel3, vel4,vel5;
PFont myFont;

// more global variables
// Here, I'm going to declare a "flag."
// Everyone makes copious use of flags.
// Flags are like off/on switches that
// we use to... well, to turn things
// off and on.  Flags are usually booleans.

boolean flagShowNames;

// that's the end of the global variables

void setup() {
    size(800, 800,FX2D);
    smooth(8);
    myFont = createFont("Helvetica",13);
    //
    // by defining name_ here, at the very
    // start of my code, I am trying make it easier
    // for people to read the rest of the code.
    // They'll know that variable1 refers to 
    // one of the Earth's characteristics;
    // or that variable4 is for Deimos.
    //
    name0 = "sol";
    name1 = "terra";
    name2 = "luna";
    name3 = "mars";
    name4 = "deimos";
    name5 = "phobos";
    flagShowNames = true;

// moons exaggerated by factor of 10
    orbit0 = 0; //sun
    orbit1 = 107.5; // earth
    orbit2 = 02.76; // moon
    orbit3 = 163.7; // mars
    orbit4 = 2.45; // phobos
    orbit5 = 3.04; // deimos

    dia0 = 100;
    dia1 = 9.1;
    dia2 = 2.4;
    dia3 = 4.87;
    dia4 = 1.8;
    dia5 = 1.6;

    //velocity in miles per second
    vel0 = 0;
    vel1 = 18;
    vel2 = 0.63;
    vel3 = 15;
    vel4 = 0.56;
    vel5 = 0.4;

    pos0=0;
    pos1=0;
    pos2=0;
    pos3=0;
    pos4=0;
    pos5=0;
	textFont(myFont, 16);
  background(10,11,12);
}

void draw() {

	// these 4 variables are
	// 'local' variables.  They
	// need to be re-declared every
	// time the draw() loop restarts.
	// I was trying to distinguish
	// between magnifying distance and
	// magnifying objects, for the 
	// purposes of better visualization.
	// But for now, it is really just
	// a bit of a jumble.

	float magnifyD = 3.0;
	float magnifyS = 2.0;
	float slowPlanet = 0.0025;
	float slowMoon = 0.8;
	background(10,10,12);

	// start from the center
	translate(width/2,height/2);

	// want to see how cool this
	// approach can be?  Delete
	// the translate line immediately
	// above this, and replace it
	// with this line:
	// translate(mouseX, mouseY);


	// SUN
	ellipse(0, 0, dia0, dia0);

	pushMatrix(); // save the current state
	// of the screen.

	// now we move things around in order
	// to draw the earth in the right place
	// but as soon as we do so, popMatrix()

	// remember that we're starting from 
	// the center of the screen, with
	// no rotation at all.

	rotate(radians(pos1));

	// orbit1 * magnify in the x position
	// of translate will take us from the
	// center of the solar system to the
	// earth's orbital path.  I multiply that
	// number by the variable magnify because
	// that will let me play with zooming
	// in on a planet later.  I use it 
	// with mars, too, for example.

	translate(orbit1 * magnifyD, 0);

	// If I were being even-handed, then
	// I'd magnify the planetary diameters,
	// too.  But there isn't enough room
	// to do so here.
	ellipse(0, 0, dia1 * magnifyS, dia1 * magnifyS);

	if (flagShowNames == true) {
		rotate(radians(-pos1));
		text(name1, dia1 * magnifyS, -dia1 * magnifyS);
	}

	// we've drawn the earth, and now 
	// we need to rotate and translate further --
	// to the moon!  

	rotate(radians(pos2));
	translate(orbit2 * magnifyD * magnifyS, 0);
	ellipse(0, 0, dia2 * magnifyS, dia2 * magnifyS);



	//Then, "POP",
	// everything snaps back into place.

	popMatrix();

	// starting from the sun again.

	rotate(radians(pos3));
	translate(orbit3 * magnifyD, 0);
	ellipse(0, 0, dia3 * magnifyS, dia3 * magnifyS);

	if (flagShowNames == true) {
		rotate(radians(-pos3));
		text(name3, dia3 * magnifyS, -dia3 * magnifyS);
	}


	pushMatrix(); // now take a picture of the screen

	// moon 1
    rotate(radians(pos4));
	translate(orbit4 * magnifyD * magnifyS, 0);
	ellipse(0, 0, dia4 * magnifyS, dia4 * magnifyS);

	// now go back to mars so we can fly
	// out to the next moon

	popMatrix();

	pushMatrix(); 
	// ...And save the screen again.
	//
  	// Not really necessary this time,
  	// since this is our last thing to draw.
  	// but if I add more later, it will
  	// be necessary, so might as well
  	// put it in.

  	// moon 2
    rotate(radians(pos5));
	translate(orbit5 * magnifyD * magnifyS, 0);
	ellipse(0, 0, dia5 * magnifyS, dia5 * magnifyS);
	popMatrix(); 
	// pushMatrix() + popMatrix()
	// should always be in pairs.

	// now update all the rotational 
	// positions by adding their
	// velocities.  NB slowPlanet
	// and slowMoon are attempts
	// to make speed scale better:
	// The planets move too quickly,
	// and the moons too slowly.
	
	pos1 = pos1 + (vel1 * slowPlanet);
	pos2 = pos2 + (vel2 * slowMoon);
	pos3 = pos3 + (vel3 * slowPlanet);
	pos4 = pos4 + (vel4 * slowMoon);
	pos5 = pos5 + (vel5 * slowMoon);	
}

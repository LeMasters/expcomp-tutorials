// fanciful mockup for poster
// for The Game (1996, USA. Dir. David Fincher).
// glemasters georgetown cct 2017

// Note that I've included a line at the 
// very end to save the graphic.  It will
// be located in the folder in which
// this code lives.  Then the code
// will immediately quit running.  You'll
// never actually see the screen.

// (So don't add those lines until you're
// 100% sure you're finished!)

void setup() {
  size(500, 500);
  smooth(8);
  background(#110A0F);
  fill(#FEFDFC);
  noStroke();
  // if the screen is 500 wide,
  // and we want 5 squares to fit,
  // they can't be bigger than
  // 100 pixels wide each
  // (500 / 5 = 100).
  // That seems reasonable
  // since we're drawing them
  // by hand (for now):  5x5
  // means 25 squares (or
  // about 12 squares, if we
  // admit we only need to draw
  // every other square.

  // So I leave a note to myself
  // and a note to others who work
  // with my code:

  // Draw the board; each rect 100x100

  rect(0, 0, 100, 100); // upper left-hand corner
  rect(200, 0, 100, 100); // skip one, then draw
  rect(400, 0, 100, 100); // skip one, then draw

  // NOW... we move down a row, and draw 
  // in the OPPOSITE columns.  e.g.,
  // x was column 0 (at 0 pixels)
  // and column 2 (at 200 pixels)
  // but
  // now its column 1 (at 100 pixels)
  // and column 3 (at 300 pixels)

  rect(100, 100, 100, 100);
  rect(300, 100, 100, 100);

  // that's it!  There's no "(500,100,n,n)" 
  // because that would be too far to the right,
  // and would never be seen by the viewer.

  // Now we just rinse and repeat.
  // In fact: I'm just going to cut and paste
  // the first 3 lines from above
  // and merely change the Y addresses (that
  // is, keep the column addresses, the X,
  // but change the vertical/row addresses, the Y.

  // Remember:
  // rect(X, Y, w, h);
  // or:  
  // rect(column, row, w, h);
  // or:  
  // rect(rightwards, downwards, w, h);

  rect(0, 200, 100, 100); // upper left-hand corner
  rect(200, 200, 100, 100); // skip one column, then draw
  rect(400, 200, 100, 100); // skip one more column, then draw

  // more cut and paste.  
  // But do you see how predictable
  // these numbers become?  We'll use that
  // to serious advantage later.
  rect(100, 300, 100, 100);
  rect(300, 300, 100, 100);

  // and again
  rect(0, 400, 100, 100); // upper left-hand corner
  rect(200, 400, 100, 100); // skip one, then draw
  rect(400, 400, 100, 100);

  //OK:  
  //That was a lot of work.  Too much.
  //And it seems like we spent a lot of time
  //repeating ourselves.  (Did I say that
  //already?) Doing the same thing
  //over and over (and over).  As our code
  //gets better, we'll get rid of those
  //repetitions altogether.  After all,
  //repetition is one of the things 
  //computers do best.

  // But we'll deal with eliminating
  // repetition later.

  // Instead, let's add a level of 
  // complexity to this design 
  // by introducing text.
  // This isn't the way we'll typically
  // do it in the future, but it works
  // for now.  Remember:  We're
  // STILL in the SETUP() function.

  // Using text is EASY in Processing
  // (not so much in other languages).
  // We have to do a few things first:
  // 1.  Load a typeface;
  // 2.  Ask the computer to prebuild it at
  //     a specific size.
  // 3.  Tell the computer to use it;
  // 4.  Write out our text.
  //
  // Which typeface to use?  If you're
  // using Mac, go with one called Avenir Neue.
  // If a PC, let's stick with Arial.  I'll
  // explain why during class.
  //
  // So a typeface is actually an OBJECT inside
  // Processing, which means it has its own
  // TYPE (like "integer" or "boolean" or "float").
  // That type is called PFont (as in Processing
  // Font).  I'll call the variable that
  // I'm using to store the font "myFont".  I use
  // "my" a lot... myFont, myClass, myMethod... we'll
  // discuss why later.

  PFont myFont;

  // Next:

  myFont = createFont("Helvetica-Bold", 130);
  // createFont is a function.  It
  // gets two arguments, always:
  // (font name, font size);
  // createFont(f,n) will ALWAYS "return"
  // a font object (that's why you're calling
  // it in the first place, obviously).  So
  // we'll always say that
  // variable = createFont(f,n);
  // and that variable always has to be
  // a type called PFont.

  // I'm just going to use X,Y coordinates
  // I pre-calculated for the layout here.
  // We'll talk about how I did that later.

  textFont(myFont);

  fill(#000000);
  text("G", 64, 400);
  text("M", 269, 400);
  
  fill(#FFFFFF);
  text("A", 172, 400);
  text("E", 372, 400);
  
  // UGH!  Not that great.  Well, it is a 
  // start.  The definite article will help
  // I think.  It has to be smaller, though.
  // Many ways to do it, here's one:

  textSize(28);
  text("THE", 36, 325);
  
  // Then, to make this design-as-I-go
  // poster more interesting, I'm going
  // to add a few letters in Chess notation.
  // Note that the movie The Game doesn't
  // really have anything to do with the
  // drama I'm about to imply with this
  // code, but it makes for an interesting
  // poster...
  
  // Create another font.  etc.
  // Note that I'm using Garamond because
  // I want a curlicue on the Queen's tail.
  // Which sounds vaguely obscene, but isn't.
  
  PFont myOtherFont;
  myOtherFont = createFont("Garamond-Italic", 91);
  textFont(myOtherFont);
  text("K",18,178);
  text("Q",318,73);
  fill(#000000);
  text("K",418,78);
  
  // SAVE IT and EXIT OUT
  
  saveFrame("The_Game.png");
  exit();
}

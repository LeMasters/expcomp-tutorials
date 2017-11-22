// uses the ColorScheme library to read ASE files
void buildColorScheme() {
    ColorScheme myColorScheme;
    ArrayList<Color> myPalette;
    String filename = int(random(1, 6)) + ".ase";
    //filename = "Ocean Moon.ase";
    myColorScheme = new ColorScheme(filename, this);
    myPalette = myColorScheme.getColors();
    workingPalette = new color[myPalette.size()];
    for (int i=0; i<workingPalette.length; i++) {
        workingPalette[i] = color(myPalette.get(i).toInt());
    }
    f = 0;
    b = 0;
    s = 0;
    while (((f==b)||(b==s)||(f==s)) && (workingPalette.length > 3)) {
        f=int(random(workingPalette.length));
        b=int(random(workingPalette.length));
        s=int(random(workingPalette.length));
    }
}
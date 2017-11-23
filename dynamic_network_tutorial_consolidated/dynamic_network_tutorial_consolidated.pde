// garrison lemasters 
// thanksgiving 2017
// georgetown university
// 

NetworkNode[] node;
float defaultDiameter;

void setup() {
    size(850, 250, FX2D);
    smooth(8);
    strokeCap(ROUND);
    defaultDiameter = 15;
    node = new NetworkNode[50];
    for (int i = 0; i < 50; i++) {

        // this may look a bit weird.  It would
        // normally say something like
        // node[i] = new NetworkNode(argument, argument);
        // But it turns out that the constructor
        // wants an ID number for each node.  So
        // I send it the same ID number as is the
        // element number of the NetworkNode array.
        // I don't use that in this code, really,
        // but if I want, I can look at any node
        // and immediately know how to access their
        // element from outside the array.  Again,
        // not using that feature here.  It is just
        // for some imaginary future use.
        node[i] = new NetworkNode(i);
    }
}

void draw() {
    background(0);
    // why use two loops (0-49) instead
    // of just one?  If I use a single
    // loop, then it draws:
    // a link (if warranted)
    // a node
    // and then increments the element number
    // and loops around again.  The problem for
    // me was that this meant some links were
    // drawn on top of the circles instead
    // of beneath them.  Gauche!  So I first
    // lay down all of the links (the lines)
    // and then draw all of the ellipses,
    // in a second loop.
    for (int i=0; i < 50; i++) {
        node[i].link(node);
    }
    for (int i=0; i < 50; i++) {
        node[i].show();
        node[i].move();

        // Above, I copy all 50 nodes to the
        // method() called link().  Notice how it says
        // ".link(node)" and not ".link(node[14])".
        // When there are no brackets next to an
        // object's name, you can almost
        // always think of it as referring to all
        // objects descended from that Class.  Think
        // node[all], or (in this case) 
        // node[0 thru 49].
    }
}

class NetworkNode {
    int nodeID;
    float xPos;
    float yPos;
    float xVel;
    float yVel;
    float diameter;
    color baseColor;

    // constructor
    // I'm only asking the user to pass an integer
    // called _id, which will become the nodeID.
    // I don't really make use of it in this
    // code, but it may be useful in a different
    // version of the code.
    NetworkNode(int _id) {
        nodeID = _id;
        xPos = random(width);
        yPos = random(height);
        xVel = random(-0.2, 0.2);
        yVel = random(-0.2, 0.2);
        diameter = defaultDiameter;
        baseColor = color(_id * 5, 90, 96);
    }

    void show() {
        strokeWeight(2);
        stroke(255);
        fill(this.baseColor);
        ellipse(this.xPos, this.yPos, this.diameter, this.diameter);
    }

    void move() {
        this.xPos = this.xPos + this.xVel;
        this.yPos = this.yPos + this.yVel;

        // edge work:  wrap-around nodes
        if (this.xPos > width) {
            this.xPos = 0;
        } else {
            if (this.xPos < 0) {
                this.xPos = width;
            }
        }
        if (this.yPos > height) {
            this.yPos = 0;
        } else {
            if (this.yPos < 0) {
                this.yPos = height;
            }
        }
    }

    // Now I have to pass a copy of my entire
    // Node array into this method() in order
    // to compare each node with the other members
    // of its cohort.  Why pass the whole thing?
    // It isn't the only way to do this, that's
    // true.  But one problem is that I don't easily
    // have access inside the method() to any
    // members of the cohort beyond this particular
    // node -- that's why we can use things like
    // this.xPos, this.diameter.  There are some
    // advanced techniques borrowed from Java:
    // theres a comparator() function that makes
    // the task possible, for example.  But since
    // the Class is fairly simple, and there aren't
    // that many objects, I just copy the whole
    // collection to a temporary version when I
    // pass an argument to this method().
    void link(NetworkNode[] nodeCopy) {

        this.diameter = defaultDiameter;
        for (int i=0; i < nodeCopy.length; i++) {
            float cohortX = nodeCopy[i].xPos;
            float cohortY = nodeCopy[i].yPos;
            float d = dist(this.xPos, this.yPos, cohortX, cohortY);

            // I change the stroke's thickness with the
            // distance between nodes.  Note that I use
            // multiplication here instead of division:
            // Since this expression is solved so frequently,
            // the choice to multiply can make a difference.
            if ((d < 85)){// && (this.nodeID<i)) {
                this.diameter = this.diameter + 1.5;
                // thickness of line decreases as line
                // reaches maximum length (70 pixels)
                strokeWeight(2);
                stroke(255);
                line(this.xPos, this.yPos, cohortX, cohortY);
            }
        }
    }
}
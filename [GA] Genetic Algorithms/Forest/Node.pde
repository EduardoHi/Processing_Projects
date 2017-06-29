class Node {
  float r, a;
  float x = -1; float y = -1;
  int index;
  Node parent;
  ArrayList<Node> sons;
  boolean isLeaf;

  Node(Node parent, int index, float r, float a) {
    this.parent = parent;
    this.index = index;
    this.r = r;
    this.a = a;
    isLeaf = true;
    sons = new ArrayList<Node>();
    x = calcX();
    y = calcY();
  }

  void display() {
    float r = isLeaf ? 6 : 3;
    ellipse(0, 0, r, r);

    for ( Node n : sons ) {
      pushMatrix();
      rotate(n.a);
      line(0, 0, 0, n.r);
      translate(0, n.r);
      n.display();
      popMatrix();
    }
  }

  void addSon(Node n) {
    sons.add(n);
    isLeaf = false;
  }

  float cost() {
    if ( isLeaf ) return 0;
    float c = 0;
    for (Node n : sons)
      c+= n.r;
    return c;
  }

  String toString() {
    int p = parent==null ? -1 : parent.index;
    return "index: "+index+" parent: "+ p +" r: "+r+" a: "+a +" x: "+x+" y: "+y;
  }  

  private float calcX() {
    if (x != -1) return x;
    if (parent== null) return 0;

    return - r*sin(accumAngle())+ parent.calcX();
  }
  private float calcY() {
    if (y != -1) return y;
    if (parent== null) return 0;

    return r*cos(accumAngle())+ parent.calcY();
  }

  float accumAngle() {
    if (parent == null) return PI;
    return a + parent.accumAngle();
  }
}
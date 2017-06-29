class Tree {
  int index, bloomTimer;
  float x, minX, maxX;
  private int size;
  ArrayList<Node> nodes;
  DNA dna;
  color c;
  float cost, tree_width, tree_height;
  float resource = 500;
  float energyPerTurn;
  boolean blossom;

  Tree( int index, float x ){
    this(index, x, new DNA() );
  }
  
  Tree( int index ){
    this( index, random(30,width-30) );
  }
  
  Tree(int index, float x, DNA dna){
    
    this.index = index;
    this.x = x;
    this.dna = dna;
    nodes = new ArrayList<Node>();
    size = 0; //variable to keep track of index of each node and the size
    bloomTimer = 0;
    blossom = false;
    
    generate();
  }
  
  void run(){
    resource -= cost;
    resource += energyPerTurn;
    
    if(bloomTimer>= dna.bloomPeriod){
      blossom = true;
      resource-= 500;
      bloomTimer = 0;
    } else 
      blossom = false;
    
    if(resource <= 0) die();
    bloomTimer++;
  }
  
  void die(){
    pop.removeTree(this);
  }
  
  void checkNodesShadow(){
    energyPerTurn = 0;
    for(Node n : nodes){
      if(!n.isLeaf) continue;
      int nodesAbove = 0;
      for(Tree t : pop.trees){
        //if(t.equals(this)) continue;
        if( n.x < t.minX || t.maxX < n.x ) continue;
        
        for(Node other : t.nodes){
          if(!other.isLeaf) continue;
          if(other.equals(n)) continue;
          
          if( abs(other.x-n.x) <= 6 && other.y < n.y ) nodesAbove++;
        }
      }
      //energyPerTurn = (float)(10.0/(Math.pow(2,nodesAbove)));
      if(!(nodesAbove>0)) energyPerTurn += energyPerLeaf;
      //else energyPerTurn = 0; 
    }
    //println("index: "+index+" energyPerTurn "+ energyPerTurn);
  }
  
  //done just once when tree is created
  void generate(){
    
    addNode( new Node(null, 0, 0, 0 ) );
    nodes.get(0).x = x;
    nodes.get(0).y = height-floor;
    size++;
    
    for(int i=0; i< dna.l ; i+= 3){

      int p = floor( map( dna.chromosome[i],0, maxRand, 0 , nodes.size() ) );
      if(p == size) p--;
      float _r = dna.chromosome[i+1];
      float _a = map( dna.chromosome[i+2],0, maxRand, -PI/2 , PI/2 );
      Node parent = nodes.get(p);
      addNode( new Node( parent, size, _r, _a ) );
      size++;
    }
    
    calcCost();
    calcDimensions();
  }
  
  void calcCost(){
    for(Node n: nodes)
      cost += n.cost();
    
    cost/=costCoef;
  }
  
  void calcDimensions(){
    float minY, maxY;
    maxX = minX = nodes.get(0).x; 
    minY = maxY = nodes.get(0).y;
    for(Node n: nodes){
      float x = n.x;
      float y = n.y;
      if(x<minX) minX = x;
      if( x>maxX ) maxX = x;
      if( y<minY ) minY = y;
      //if( y>maxY ) maxY = y;
    }
    //println(index+ " ************* minX: "+ minX+ " maxX: "+ maxX +" minY: "+ minY+ " maxY: "+maxY);
    tree_width = maxX-minX;
    tree_height = minY-maxY;
  }
  
  void addNode( Node n ){
    nodes.add( n );
    if(n.parent != null) n.parent.addSon( n );
  }
  
  void display(){

    
    stroke(dna.c);
    fill(dna.c);
    
    pushMatrix();
    
    translate(x, height-floor);
    
    if(debug){
        text(index, -2 , 15);
        text(cost, -2 , 26); 
        text(resource, -2, 37);
        text(bloomTimer+"/"+dna.bloomPeriod, -2, 48);
        
    }
    rotate(PI);
    nodes.get(0).display();
    
    popMatrix();
  }
  
  void print(){
    println("tree_index: " + index + " segments: "+dna.segments +" energyPerTurn: "+energyPerTurn);
    println("cost: " + cost + " width: "+tree_width + " height: " + tree_height + " minX: "+minX+" maxX: "+maxX);
    for(Node n: nodes){
      println(n);
    }
    println("----------------------------------");
  }
  
}
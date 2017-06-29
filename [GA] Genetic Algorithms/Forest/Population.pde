class Population {
  ArrayList<Tree> trees = new ArrayList<Tree>(popSize);
  int totalIndex = 0;
  
  Population(){
    for(int i=0; i< popSize; i++){
      addTree( new Tree( totalIndex ) );
    }
  }
  
  void run(){
    for( int i=0; i<trees.size(); i++){
      Tree t = trees.get(i);
      t.run();
      if( t.blossom ) asexual(t);
    }
  }
  
  void asexual(Tree parent) {
    float newX = parent.x + random(-50,50);
    for(Tree t: trees)
      if(abs(t.x-newX)<3) return;
    addTree( new Tree(totalIndex, newX , parent.dna.mutate() ) );
    checkAllShadow();
  }
  
  void display(){
    for( Tree t : trees){
      t.display();
    }  
  }
  void checkAllShadow(){
    for( Tree t : trees){
      t.checkNodesShadow();
    }
  }
  
  void addTree( Tree t){
    trees.add( t );
    totalIndex ++;
  }
  
  void removeTree(Tree t){
    trees.remove( t );
    checkAllShadow();
  }
  
  void randomize(){
    trees.clear();
    for(int i=0; i< popSize; i++){
      addTree( new Tree( totalIndex ) );
    }
  }
  
  void print(){
    for(Tree t : trees){
      t.print();
    }
  }
  
}
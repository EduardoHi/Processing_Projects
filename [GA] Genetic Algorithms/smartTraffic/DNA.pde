class DNA {
  int length = ceil(lifespan/10);
  boolean[] genes = new boolean[length];
  
  DNA(boolean[] g){
    length = g.length;
    this.genes = g;
  }
  DNA(){
    for(int i=0; i<length ; i++){
      float p = random(1,2);
      if(p<1.5) genes[i] = true;
      else genes[i] = false;
    }
  }
  DNA crossover(DNA p){
    boolean[] newgenes = new boolean[genes.length];
    int mid = floor(random(genes.length));
    
    for(int i =0; i<genes.length ;i++){
      if(i > mid){
        newgenes[i] = this.genes[i];
      }else{
        newgenes[i] = p.genes[i];
      }
    }
    DNA child = new DNA(newgenes);
    return child;
  }
  void mutation(){
    for(int i = 0;i<genes.length;i++){
      if(random(1)<mutationRate){
        genes[i] = !genes[i];
      }
    }
    
  }
  
}
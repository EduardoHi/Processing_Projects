class DNA{
  PVector[] genes = new PVector[lifespan];
  DNA(){
    for(int i=0; i<lifespan;i++){
      genes[i] = PVector.random2D();
      genes[i].setMag(0.2);
    }
  }
  DNA(PVector[] genes){
    this.genes = genes;
  }
  DNA crossover(DNA p,int mid){
    PVector[] newgenes = new PVector[genes.length];
    
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
      if(random(1)<0.005){
        genes[i] = PVector.random2D();
        genes[i].setMag(0.1);
      }
    }
  }
  
}
class DNA {
  float[] genes;
  int size = 3;
  float mutationProb = 0.05;
  float mutationMag = 0.09;
  
  DNA(){
    genes = new float[size];
    for(int i=0; i<3 ; i++){
      genes[i] = random(-1,1);
    }
  }
  DNA(float[] genes){
    this.genes = genes;
  }
  
  DNA crossover(DNA p, int mid){
    float[] newgenes = new float[3];
    
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
      if(random(1)<mutationProb){
 
        genes[i] += random(-mutationMag,mutationMag);
        //if(genes[i]>1) genes[i]=1;
        //if(genes[i]<-1) genes[i]=-1;
      }
    }
    
  }
}
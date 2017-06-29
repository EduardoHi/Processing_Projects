class DNA {
  float[] genes;
  int len = 36;

  DNA(){
    genes = new float[len];
    for (int i = 0; i < 30; i++) {
      genes[i] = random(-1,1);
    }
    for(int i=30; i<=32;i++){
      genes[i] = random(10)+3;
    }
    for(int i=33; i<=35;i++){
      genes[i] = random(0,1);
    }
  }
  DNA(float[] newgenes) {
    genes = newgenes;
  }
  
  DNA crossover(DNA partner) {
    float[] child = new float[genes.length];
    int crossover = int(random(genes.length));
    for (int i = 0; i < genes.length-3; i++) {
      if (i > crossover) child[i] = genes[i];
      else               child[i] = partner.genes[i];
    }
    for (int i = 33; i < genes.length; i++) {
      child[i] = lerp(genes[i],partner.genes[i],0.5);
    }
    DNA newgenes = new DNA(child);
    return newgenes;
  }
  
  // Based on a mutation probability, picks a new random character in array spots  
  void mutate() {
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < mutationRate) {
        if(i>=33) genes[i] += random(-0.5,0.5);
         else genes[i] += random(-1,1);
      }
    }
  }  
}
class DNA {
  float[] chromosome;
  int l;
  int segments;
  int bloomPeriod;
  color c;

  DNA() {
    segments = round(random(2, 10));
    bloomPeriod = round(random(10, 300));
    l = segments*3;

    chromosome = new float[l];
    for (int i=0; i<l; i++) {
      chromosome[i] = random(0, maxRand);
    }
    c = color( random(255), random(255), random(255) ) ;
  }
  DNA(DNA other){
    this.chromosome = other.chromosome;
    this.l = other.l;
    this.segments = other.segments;
    this.bloomPeriod = other.bloomPeriod;
    this.c = other.c;
  }

  void crossover( DNA d ) {
  }
  
  DNA mutate() {
    DNA copy = new DNA(this);
    if(random(1)<mutationRate) bloomPeriod += random(-20,20);
    if(random(1)<mutationRate) c+= random(-2,2);
    
    if(random(1)<mutationRate/2){
      copy.segments+= 1*Math.signum(random(-1,1));
      if(copy.segments == 0) copy.segments++;
      copy.l = copy.segments*3;
      copy.chromosome = Arrays.copyOf(chromosome, copy.l);  
    }
    
    for(int i=0; i<copy.chromosome.length; i++){
      if(random(1)<mutationRate)  copy.chromosome[i] += random(-maxRand/4, maxRand/4);
      if(copy.chromosome[i]<0) copy.chromosome[i] *= 0;
      if(copy.chromosome[i]>maxRand) copy.chromosome[i] = maxRand;
    }
    
    return copy;
  }
}
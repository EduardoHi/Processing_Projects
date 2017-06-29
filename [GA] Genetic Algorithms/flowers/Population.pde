class Population {
  Flower[] flowers;
  ArrayList<Flower> matingPool;
  
  Population() {
    flowers = new Flower[popSize];
    matingPool = new ArrayList<Flower>();
    generateFlowers(new DNA[0]);
  }
  void generateFlowers(DNA[] dna){
    for (int i = 0; i < flowers.length; i++) {
      float x = 100;
      float y = 0;
      if(i<5){
        x += i*(1+2*width/popSize);
        y = height/4;
      }
      else{
        x += (i-5)*(2*width/popSize);
        y = 30+ height/2;
      }
      if(dna.length>0)flowers[i] = new Flower(dna[i], x, y);
      else flowers[i] = new Flower(new DNA(), x, y); 
    }
  }
  
  void nextGen(){
    selection();
    reproduction();
  }
  
  void drawFlowers(){
    for (int i = 0; i < flowers.length; i++) {
      flowers[i].drawFlower(flowers[i].wh);
    }
  }
  void display() {
    for (int i = 0; i < flowers.length; i++) {
      flowers[i].display();
    }
  }
  void rollover(int mx, int my) {
    for (int i = 0; i < flowers.length; i++) {
      flowers[i].rollover(mx, my);
    }
  }
   void selection() {
    // Clear the ArrayList
    matingPool.clear();

    // Calculate total fitness of whole population
    float maxFitness = getMaxFitness();
    
    for (int i = 0; i < flowers.length; i++) {
      float fitnessNormal = map(flowers[i].fitness , 0, maxFitness, 0, 1);
      int n = (int) (fitnessNormal * 100);  // Arbitrary multiplier
      for (int j = 0; j < n; j++) {
        matingPool.add(flowers[i]);
      }
    }    
   }
  void reproduction() {
    DNA[] newdnas = new DNA[flowers.length];
    // Refill the population with children from the mating pool
    for (int i = 0; i < flowers.length; i++) {
      // Sping the wheel of fortune to pick two parents
      int m = int(random(matingPool.size()));
      int d = int(random(matingPool.size()));
      // Pick two parents
      Flower mom = matingPool.get(m);
      Flower dad = matingPool.get(d);
      // Get their genes
      DNA momgenes = mom.dna;
      DNA dadgenes = dad.dna;
      // Mate their genes
      DNA child = momgenes.crossover(dadgenes);
      // Mutate their genes
      child.mutate();
      
      newdnas[i] = child;
    }
    // Fill the new population with the new child
    generateFlowers(newdnas);
  }
  
   float getMaxFitness(){
      float record = 0;
    for (int i = 0; i < flowers.length; i++) {
      if (flowers[i].fitness > record) {
        record = flowers[i].fitness;
      }
    }
    return record;   
   }
  
  
  
  
  
}
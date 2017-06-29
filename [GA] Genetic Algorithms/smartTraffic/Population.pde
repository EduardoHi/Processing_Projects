class Population {
int popSize = 20;
Sim[] sims = new Sim[popSize];
ArrayList<Semaforo> matingPool;
Semaforo bestSem = new Semaforo();
Sim bestSim = new Sim(new Semaforo());
float minFit = 1000000;
float avgFit = 0;
int rndmIndex;

Population(){
  Semaforo[] semaforos = new Semaforo[popSize];
  for(int i=0; i<popSize; i++){
    semaforos[i] = new Semaforo();
    sims[i] = new Sim(semaforos[i]);
  }
  rndmIndex = floor( random(popSize) );
  sims[rndmIndex].displayed = true;
  
  matingPool = new ArrayList<Semaforo>();
}
void nextGen(){
  this.evaluate();
  this.avgFit();
  this.selection();
  rndmIndex = floor( random(popSize) );
  sims[rndmIndex].displayed = true;
}
void evaluate(){
  matingPool.clear();
  minFit = 1000000;
  //calculate all fitness and best fitness
  for(int i=0; i<popSize ;i++){
    sims[i].sem.calcFitness(i);
    float f = sims[i].sem.fitness;
    if(f<minFit){
      minFit = f;
      bestSim = sims[i];
      bestSem = sims[i].sem;
    }
  }
  //normalize all fitness
  for(int i=0; i<popSize; i++){
      sims[i].sem.normFit = minFit/sims[i].sem.fitness; 
  }
  //add semaforos to the mating pool
  for( int i=0; i<popSize; i++){
    int n = (int)(sims[i].sem.normFit*100);
    for( int j=0; j<n; j++){
      matingPool.add(sims[i].sem);
    }
  }
  
}
  void run(){
    stroke(240);
    text(rndmIndex,width-30,30);
    for( int i=0; i<popSize;i++){
      currentSim = i;
      sims[i].run();
      //bestSim.run();
    }
  }
  
  void selection(){
    Semaforo[] newSemaforos = new Semaforo[popSize];
    for(int i = 0; i<popSize;i++){
      int A = floor(random(matingPool.size()));
      int B = floor(random(matingPool.size()));
      DNA parentA = matingPool.get(A).dna;
      DNA parentB = matingPool.get(B).dna;
      
      DNA newdna = parentA.crossover(parentB);
      
      newdna.mutation();
      
      Semaforo child = new Semaforo(newdna);
      newSemaforos[i] = child;
    }
    for(int i=0; i<popSize; i++){
      sims[i] = new Sim(newSemaforos[i]);
    }
  }
  void avgFit(){
    float sum = 0;
    for(int i = 0;i<popSize;i++){
      sum += sims[i].sem.fitness;
      // println("Sim # "+i);
      // sims[i].displayStats();
      // println("-------");
    }
    avgFit = sum / popSize;
    //println("Sim # "+);
    println("BestFit: "+minFit);
    println("avgFit: "+avgFit);
    println("---------------------");
  }
}
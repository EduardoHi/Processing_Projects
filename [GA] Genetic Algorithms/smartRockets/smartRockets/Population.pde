class Population{
  int popsize = 10;
  Rocket[] rockets = new Rocket[popsize];
  Rocket best;
  ArrayList<Rocket> matingpool;
  float maxFit = 0;
  float fit2 = 0;
  float fit3 = 0;
  float avgFit = 0;
  int bestTime = 0;
  
  Population(){
    for( int i=0; i<popsize;i++){
      rockets[i] = new Rocket();
    }
    matingpool = new ArrayList<Rocket>();
  }
  void evaluate(float [] fitFun){
    matingpool.clear();
    maxFit = 0;
    fit2 = 0;
    fit3 = 0;
    for( int i=0; i<popsize;i++){
      
      rockets[i].calcFitness(fitFun);
      float f = rockets[i].fitness; 
      if( f>maxFit ){ 
      maxFit = f;
      best = new Rocket(rockets[i]);
      } else if( f>fit2 ){
        fit2 = f;
      } else if( f>fit3 ){
        fit3 = f;
      }
    }
    for( int i=0; i<popsize;i++){
      rockets[i].normFit = rockets[i].fitness/maxFit;
    }
    
    for( int i=0; i<popsize;i++){
      Rocket r = rockets[i];
      addToPool(r);
    }
  }
  void addToPool(Rocket r){
    int n = (int)(r.normFit*100);
    for( int j=0; j<n;j++){
        matingpool.add(r);
      }
  }
  void run(){
    for( int i=0; i<popsize;i++){
      rockets[i].update();
      rockets[i].display();
    }
  }
  void display(){
    for(Rocket r :rockets)
      r.display();
  }
  void selection(){
    Rocket[] newRockets = new Rocket[rockets.length];
    for(int i = 0; i<rockets.length;i++){
      int A = floor(random(matingpool.size()));
      int B = floor(random(matingpool.size()));
      DNA parentA = matingpool.get(A).dna;
      DNA parentB = matingpool.get(B).dna;
      
      int mid = floor(random(lifespan));
      DNA newdna = parentA.crossover(parentB,mid);
      
      newdna.mutation();
      color childC = lerpColor(matingpool.get(A).c,matingpool.get(B).c,0.5);
      
      Rocket child = new Rocket(newdna,childC);
      newRockets[i] = child;
    }
    rockets = newRockets;
  }
  float avgFit(){
    float sum = 0;
    for(int i = 0;i<popsize;i++){
      sum += rockets[i].fitness;
    }
    avgFit = sum / popsize;
    return avgFit;
  }
  void displayStats(){
    println("1: "+ maxFit*1000);
    println("2: "+ fit2*1000);
    println("3: "+ fit3*1000);
    println("avgFit: "+ avgFit()*1000);
    //println("mating pool size: " + matingpool.size());
    println("-----------------------------");
    avgFit = avgFit();
    bestTime = best.finishTime;
  }
}
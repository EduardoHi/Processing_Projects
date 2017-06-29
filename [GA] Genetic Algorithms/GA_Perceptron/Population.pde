class Population {
  int popSize = 10;
  Perceptron[] perceptrons;
  ArrayList<Perceptron> matingpool;
  float maxScore = 0;
  
  Population(){
    perceptrons = new Perceptron[popSize];
     for( int i=0; i<popSize;i++){
      perceptrons[i] = new Perceptron();
    }
    matingpool = new ArrayList<Perceptron>();
  }
  
  void run(boolean drawing){
    for( int i=0; i<popSize;i++){
      if(drawing)perceptrons[i].display(false);
      perceptrons[i].updateScore(training[count].answer);
    }
  }
  void nextGen(){
    this.evaluate();
    this.selection();
  }
  void evaluate(){
    matingpool.clear();
    maxScore = 0;
    for( int i=0; i<popSize;i++){
      int score = perceptrons[i].score;
      if(score>maxScore){
        maxScore = score;
        if(Best.score<score)
        Best = new Perceptron(perceptrons[i]);
      }
    }
    for( int i=0; i<popSize;i++){
      perceptrons[i].fitness = perceptrons[i].score/maxScore;
    }
    for( int i=0; i<popSize;i++){
      int n = (int)(perceptrons[i].fitness*100);
      for(int j=0; j<n ; j++ ){
        matingpool.add(perceptrons[i]);
      }
    }
  
  }
  
  void selection(){
   Perceptron[] newPop = new Perceptron[popSize];
   for( int i=0; i<popSize;i++){
      int A = floor(random(matingpool.size()));
      int B = floor(random(matingpool.size()));
      DNA parentA = matingpool.get(A).dna;
      DNA parentB = matingpool.get(B).dna;

      
      
      int mid = floor(random(3));
      DNA newdna = parentA.crossover(parentB , mid);
      newdna.mutation();
      
      color childC = lerpColor(matingpool.get(A).c,matingpool.get(B).c,0.5);
      Perceptron child = new Perceptron(newdna,childC);
      //child.printW();
      newPop[i] = child;
   }
   perceptrons = newPop;
  }
  void displayStats(){
    /*+for( int i=0; i<popSize;i++){
      println(i+" score: "+perceptrons[i].score);   
    }*/
    println("-----------------------");
    println("maxScore: "+maxScore);
    println("avg Score "+avgScore());
  }
  float avgScore(){
    float sum = 0;
    for(Perceptron p : perceptrons){
      sum += p.score;
    }
    return sum/popSize;
  }
}
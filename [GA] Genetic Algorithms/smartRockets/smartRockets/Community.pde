class Community {
  float interspeciesProb = 0.1;
  Specie[] species;
  int comSize = 7;
  Community(){
    species = new Specie[comSize];
    color[] cs = new color[comSize];
    for(int i=0;i<comSize;i++){
      cs[i] = color(255*(i)/comSize,255,255);
      species[i] = new Specie(cs[i], randomFitFun() );
    }
  }
  float[] randomFitFun(){
    float[] f = new float[4];
    f[0] = random(0,2);
    f[1] = random(0,2);
    f[2] = random(0,4);
    f[3] = random(0,0.5);
    return f;
  }
  void run(){
    for(Specie s: species){
    s.run();
    }
  }
  void display(){
    for(Specie s: species)
    s.display();
  }
  void nextGen(){
    
      for(int i=0; i<comSize ; i++){
        species[i].evaluate();
        species[i].displayStats();
        species[i].selection();
        
        for(int j=0; j<species[i].popsize ; j++){
          
          if(random(1)<interspeciesProb){
            int speciei =(int)floor(random(0,comSize));
            debug++;
            Rocket r = species[i].rockets[j]; 
            r.normFit/=10;
            species[speciei].addToPool(r);
          }
          
        }
        
      }
      
  }
}
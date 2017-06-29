class Semaforo {
  DNA dna;
  boolean state; 
  PVector pos = new PVector(width/2, height/2);
  float fitness;
  float normFit;
  int w = 10;
  int h = 80;
  
  Semaforo(DNA newdna){
    this.dna = newdna;
  }
  Semaforo(Semaforo s){
  this.state = s.state;
  this.pos = s.pos;
  this.fitness = s.fitness;
  this.normFit = s.normFit;
  this.w = s.w;
  this.h = s.h;
  }
  Semaforo(){
    dna = new DNA();
  }
  void run(){
      this.update();  
      this.display();
  }
  
  void update(){
    state = dna.genes[turn];
  }
  
  void calcFitness(int i){
    this.fitness = pop.sims[i].totalWaitTime/10000;
    this.fitness += 6*pop.sims[i].totalCrashes;
    this.fitness -= pop.sims[i].totalCompleted*2;
  }  
  
  
  void display(){
    color c1,c2;
    if(state){
      c1 = color(255,20,20);
      c2 = color(20,255,20);
    }else{
      c2 = color(255,20,20);
      c1 = color(20,255,20);
    }
    
    pushMatrix();
      translate(pos.x,pos.y);
      strokeWeight(w);
      
      pushMatrix();
        stroke(c1);
        translate(-50,-40);
        line(0,0,0,h);
      popMatrix();
      
      pushMatrix();
        stroke(c2);
        translate(-40,50);
        line(0,0,h,0);
      popMatrix();
      
    popMatrix();
  }
}
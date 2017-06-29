class Rocket {
  PVector pos = new PVector(width/2,height);
  PVector vel = new PVector(0,0);
  PVector acc = new PVector(0,0);
  float fitness = 0;
  float normFit = 0;
  float recordDist = 10000;
  float totalDists = 0;
  int finishTime = 0;
  int size = 8;
  boolean completed = false;
  boolean crashed = false;
  
  DNA dna;
  color c;

  Rocket(){
    dna = new DNA();
    int r1 = (int)random(255);
    int r2 = (int)random(255);
    int r3 = (int)random(255);
    c = color(r1,r2,r3,200);
  }
  Rocket(Rocket r){
    this.dna = r.dna;
    this.c = r.c;
    this.finishTime = r.finishTime;
  }
  Rocket(DNA dna,color c){
    this.dna = dna;
    this.c = c;
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }

  void update(){
    
    float d = dist(pos.x,pos.y,target.x,target.y);
    if (d < recordDist) recordDist = d;
    if(d<10){
      completed = true;
    }
    for(Obstacle o: obs){
      if(o.checkCollision(pos.x,pos.y))
        crashed = true;
    }
    
    //map boundaries
    if(pos.x<=0||pos.x>=width||pos.y<=0||pos.y>=height+10){
      crashed = true;
    }
    
    if(!completed){
      if(!crashed){
        totalDists += d;
        applyForce(dna.genes[count]);
        vel.add(acc);
        pos.add(vel);
        acc.mult(0);
      }
    finishTime++;
    }
  }

  void display(){
    if(drawG){
      pushMatrix();
      translate(this.pos.x, this.pos.y);
      rotate( vel.heading()+(PI/2) );
      colorMode(HSB);
      stroke(255);
      
      // Thrusters
      rectMode(CENTER);
      fill(c);
      rect(-size / 2, size * 2, size / 2, size);
      rect(size / 2, size * 2, size / 2, size);
  
      // Rocket body
      fill(c);
      beginShape(TRIANGLES);
      vertex(0, -size * 2);
      vertex(-size, size * 2);
      vertex(size, size * 2);
      endShape(CLOSE);
  
      popMatrix();
    }
  }
  
  void calcFitness(){
    if (recordDist < 1) {
      recordDist = 1;
    }
    fitness = 1;
    fitness /= recordDist;
    fitness /= finishTime;
    
    if(completed) fitness *= 2;
    
    if(crashed) fitness*= 0.1;
  }
  void calcFitness(float[] f){
    if (recordDist < 1) recordDist = 1;
    if( crashed ) finishTime = lifespan;
    
    fitness = 1;
    fitness /= (recordDist*f[0]);
    fitness /= (finishTime*f[1]);
    
    if(completed) fitness *= f[2];
    
    if(crashed) fitness*= f[3];
  }

}
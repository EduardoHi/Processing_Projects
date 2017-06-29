class Car {
  int maxVel = 2;
  int r = 12; //size
  int depart;
  int arrive = floor(random(2,4));
  int waitingTime = 0;
  
  PVector pos = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  
  PVector target;
  
  boolean crashed = false;
  boolean reached = false;
  boolean waiting = false;
  boolean gonnaCrash = false;
  
  Car(int d){
    this.depart = d;
    if(this.depart == 0){
      pos.x = 0;
      pos.y = height/2 + random(-10,10);
    }else{
      pos.x = width/2 + random(-10,10);
      pos.y = height;
    }
    target = new PVector( width/2 , height/2 );
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }
  
  void run(){
    this.update();    
    this.display();
  }
  
  void update(){
    if(crashed){
      pop.sims[currentSim].totalCrashes++;
    }
    if(pos.x>=width||pos.y<=0){
      pop.sims[currentSim].totalCompleted++;
    }
    if(pos.x>=width||pos.y<=0||crashed) pop.sims[currentSim].cars.remove(this);
    
    float dist2check = pos.dist(target);
    if( dist2check < 10 ){
      if(this.arrive==2){
        target = new PVector(width , height/2);
      }else{
        target = new PVector(width/2, 0);
      }
      reached = true;
    } else {
      reached = false;
    }
    
    if(depart==0){
      if(pop.sims[currentSim].sem.state){
        float dist2Semaforo = pos.dist(new PVector(width/2-25,height/2));
        if(dist2Semaforo<20){
          brake(-2);
          waiting = true;
        }
      } else {
        waiting = false;
        }  
    }else{
      if(!pop.sims[currentSim].sem.state){
        float dist2Semaforo = pos.dist(new PVector(width/2,height/2+25));
        if(dist2Semaforo<20){
          brake(-2);
          waiting = true;
        }
      } else {
        waiting = false;
        }
    }
    if(!crashed){

      if(!waiting&&!gonnaCrash){
        forward();
      }
      else{
        waitingTime++;
      }
      vel.add(acc);
      if(vel.mag()<0.2) vel.mult(0);
      pos.add(vel);
      acc.mult(0);
    }
    this.checkCollision();
    this.gonnaCrash();
  }
  
  void checkCollision(){
    for(Car c: pop.sims[currentSim].cars){
      if(!c.equals(this)){
        float d = this.pos.dist(c.pos);

        if(d<1.5*r){
          this.crashed = true;
        }
      }
    }
  }
  
  void gonnaCrash(){
    for(Car c: pop.sims[currentSim].cars){
      if(!c.equals(this)){
        PVector futcpos = c.pos.copy().add(c.vel);
        PVector futpos = pos.copy().add(this.vel);
        PVector direction = c.pos.copy();
        direction.sub(this.pos);
        float heading = abs(vel.heading() - direction.heading());
          if( heading<PI/2 ){
          float d = futpos.dist(futcpos);
          if (d<3*r){
            brake(-2);
            gonnaCrash = true;
            waiting = true;
          }
        }else {
          gonnaCrash = false;
        }
      }
    }
  }
  
  void brake(float f){
    PVector force = vel.copy().normalize();
    force = force.mult(f);
    applyForce(force);
  }
  
  void forward(){
    PVector desiredVel = PVector.sub(target , pos);
    desiredVel.normalize();
    desiredVel.mult(maxVel);
    applyForce( PVector.sub( desiredVel , vel ));
  }
  void display(){
    pushMatrix();
      
      translate(pos.x,pos.y);
      rotate(vel.heading() + (PI/2));
      strokeWeight(1);
      stroke(255);
      if(this.arrive == 3){
        fill(0,0,255);
        rectMode(CENTER);
        rect(0,0,r,r*2);
      }else if (this.arrive == 2){
        fill(0,255,0);
        rectMode(CENTER);
        rect(0,0,r,r*2);
      }
    popMatrix();
    
  }
}
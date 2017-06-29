class Car {
  PVector loc;
  PVector vel;
  PVector acc;
  float friction = 1;
  float maxSpeed;
  int maxForce = 3;
  boolean reached = false;
  
  Car(float x, float y,float mS){
    loc = new PVector(x,y);
    vel = new PVector();
    acc = new PVector();
    this.maxSpeed = mS;
  }
  
  void move(){
    loc.add(vel);
    vel.add(acc);
    vel.mult(friction);
    acc.setMag(0);
    if(loc.x>width) vel.x*=-1;
    if(loc.x<0) vel.x*=-1;
    if(loc.y>height) vel.y*=-1;
    if(loc.y<0) vel.y*=-1;
  }
  
  void applyForce(PVector f){
    acc = f;
  }
  
  float dist2(PVector a){
    return sqrt((loc.x-a.x)*(loc.x-a.x)+(loc.y-a.y)*(loc.y-a.y));
  }
  
  void seek(PVector t){
    PVector desired = PVector.sub(t,loc);
    desired.normalize();
    desired.mult(maxSpeed);
    PVector seek = PVector.sub(desired,vel);
    
    applyForce(seek);
  }
  
  void display(){
    fill(255);
    rectMode(CENTER);
    
    pushMatrix();
    translate(loc.x,loc.y);
    rotate(vel.heading());
    rect(0,0,20,13);
    popMatrix();
    
  }

}
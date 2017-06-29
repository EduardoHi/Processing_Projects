class Asteroid {
  PVector[] points;
  int n;
  float rad = 50;
  PVector pos;
  PVector vel;
  PVector acc;
  
  Asteroid(PVector v){
    n= 8;
    points = new PVector[n];
  
    float angle = 0;
    
    for(int i=0; i<points.length; i++){
      float offset = random(-15,15);
      float x = cos(angle)*(rad+offset);
      float y = sin(angle)*(rad+offset);
      points[i] = new PVector(x,y);
      angle += 2*PI/n;
    }
    
    pos = new PVector(random(width),random(height));
    vel = v;
    acc = new PVector();
  }
  void update(){
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
    if(pos.x<0||pos.x>width||pos.y<0||pos.y>height){
      del();
    }
  }
  
  void del(){
    asteroids.remove(this);
  }
  void applyForce(PVector f){
    acc = f;
  }
  
  void display(){
    pushMatrix();
    translate(pos.x,pos.y);
    beginShape();
    for(int i=0; i<points.length; i++){
      vertex( points[i].x , points[i].y );
    }
    endShape();
    popMatrix();
  }
  
  void seek(PVector p){
    PVector desired = PVector.sub(p,pos);
    desired.normalize();
    desired.mult(0.5);
    PVector seek = PVector.sub(desired,vel);
    
    applyForce(seek);
  }
}
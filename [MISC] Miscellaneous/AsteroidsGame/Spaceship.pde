class Spaceship {
  PVector loc;
  PVector vel;
  PVector acc;
  
  float damping = 0.995;
  float maxSpeed = 6;
  
  float heading = 0;
  
  float r = 16;
  
  boolean thrusting = false;
  boolean crashed = false;
  
  Spaceship() {
    loc = new PVector(width/2,height/2);
    vel = new PVector();
    acc = new PVector();
  } 
  
  void update(){
    vel.add(acc);
    vel.mult(damping);
    vel.limit(maxSpeed);
    loc.add(vel);
    acc.mult(0);
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }
  
  void turn(float a) {
    heading += a;
  }
  
  void thrust(int d) {
    float angle = heading-PI/2;
    
    PVector force = new PVector(cos(angle),sin(angle));
    force.mult(0.1*d);
    applyForce(force);
    
    thrusting = true;
  }
  
  void wrapEdges() {
    float buffer = r*2;
    if (loc.x > width +  buffer) loc.x = -buffer;
    else if (loc.x <    -buffer) loc.x = width+buffer;
    if (loc.y > height + buffer) loc.y = -buffer;
    else if (loc.y <    -buffer) loc.y = height+buffer;
  }
  
  void display() { 
    stroke(0);
    strokeWeight(2);
    pushMatrix();
    translate(loc.x,loc.y+r);
    rotate(heading);
    fill(175);
    if (thrusting) fill(255,0,0);
    // Booster rockets
    rect(-r/2,r,r/3,r/2);
    rect(r/2,r,r/3,r/2);
    fill(175);
    if(crashed) fill(240,0,240);
    // A triangle
    beginShape();
    vertex(-r,r);
    vertex(0,-r);
    vertex(r,r);
    endShape(CLOSE);
    rectMode(CENTER);
    popMatrix();
    
    thrusting = false;
  }
  
  void checkCollisions(){
    for(Asteroid ast : asteroids){
      float a = ast.pos.x-this.loc.x;
      float b = ast.pos.y-this.loc.y;
      float d = sqrt( (a*a)+(b*b) );
      if(d< r+ast.rad) crashed = true;
    }
  }
  
  
}
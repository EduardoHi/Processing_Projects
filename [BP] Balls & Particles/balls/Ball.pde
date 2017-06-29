class Ball {
  PVector p;
  PVector v;
  PVector a;
  float r;
  float m;
  
  Ball( int vx , int vy ){
    this.p = PVector.random2D();
    p.x = random(width);
    p.y = random(height);
    this.v = new PVector(vx,vy);
    
  }
  
  Ball(){
    this.p = PVector.random2D();
    p.x = random(width);
    p.y = random(height);
    this.v = new PVector();
    this.a = new PVector();
    this.r = random(4,10);
    this.m = r*r*PI;
  }
  
  void update(){
    p.add(v);
    v.add(a);
    a.mult(0);
    constrain();
  }
  void display(){
    pushMatrix();
    translate( p.x , p.y );
    noStroke();
    fill(255);
    ellipse( 0,0 , 2*r,2*r );
    popMatrix();
  }
  
  void applyForce(PVector f){
    pushMatrix();
    translate( p.x , p.y );
    stroke(230,0,0);
    line(0,0,f.x,f.y);
    popMatrix();
    this.a = f.div(this.m);
  }
  
  void constrain(){
    if(p.x<0||p.x>width) v.x *= -1;
    if(p.y<0||p.y>height) v.y *= -1;
  }
}
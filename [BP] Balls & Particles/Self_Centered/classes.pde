
class Point{
  float x,y;
  Point(){ this(random(width),random(height)); }
  Point(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  float dist2(Point o){ return (x-o.x)*(x-o.x) + (y-o.y)*(y-o.y); }
  
  float dist(Point o){ return sqrt(dist2(o)); }
  
  void display(){
    ellipse(x,y,5,5);
  }
}

class Particle extends Point {
  float mass, d, r;
  float vx, vy, ax, ay;
  boolean inCollision = false;
  Particle(){
    this(1);
  }
  
  Particle(float mass){
    this(mass, random(width), random(height) );
  }
  
  Particle(float mass, float x, float y){
    super(x,y);
    vx = random(-maxVel, maxVel);
    vy = random(-maxVel, maxVel);
    //vx = vy = ax = ay = 0;
    ax = random(-maxAcc, maxAcc);
    ay = random(-maxAcc, maxAcc);
    this.mass = mass;
    r = mass/10;
    d = 2*r;
  }
  
  void wrap(){
    if(x > width) x = 0;
    if(x < 0) x = width;
    if(y > height) y = 0;
    if( y < 0) y = height;
  }
  void border(){
    if(x > width ){
      vx =-vx;
      x = width;
    }
    if(x < 0){
      vx =-vx;
      x = 0;
    }
    if(y > height){
      vy = -vy;
      y = 0;
    }
    if( y < 0){
      vy = -vy;
      y = height;
    }
  }
  
  void update(Particle o){
    x += vx;
    y += vy;    
    vx += ax;
    vy += ay;
    ax = ay = 0;
    
    vx*=friction;
    vy*=friction;
    
    wrap();
    //border();
  }
  
  void applyForce(float fx, float fy){
    ax += fx/mass;
    ay += fy/mass;
  }
  
  boolean collisions(Particle o){
      if( dist2(o) < (o.r+r)*(o.r+r) ){
        float ty = mass*vy;
        float tx = mass*vx;
        vx = o.vx*o.mass/mass*e_loss;
        vy = o.vy*o.mass/mass*e_loss;
        o.vy = ty/o.mass*e_loss;
        o.vx = tx/o.mass*e_loss;
        display(color(255,100));
        return true;
      }
      return false;
  }
  
  void display(color c){
    fill(c);
    ellipse(x, y, d, d);
    stroke(255);
    line(x,y,x+vx,y+vy);
    noStroke();
  }
  
}
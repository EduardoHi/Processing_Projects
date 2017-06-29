
class point{
  float x,y;
  point(){ x = random(width); y = random(height); }
  
  float dist2(point o){ return (x-o.x)*(x-o.x) + (y-o.y)*(y-o.y); }
  
  float dist(point o){ return sqrt(dist2(o)); }
  
  void display(){
    ellipse(x,y,5,5);
  }
}

class particle extends point {
  float vx, vy;
  particle(){
    super();
    vx = random(-maxVel, maxVel);
    vy = random(-maxVel, maxVel);
  }
  void update(){
    x += vx;
    y += vy;
    if(x > width) x = 0;
    if(x < 0) x = width;
    if(y > height) y = 0;
    if( y < 0) y = height;
  }
}

class chargedParticle extends particle {
  float ax, ay;
  chargedParticle(){
    super();
    ax = random(-maxAcc, maxAcc);
    ay = random(-maxAcc, maxAcc);
  }
  void update(){
    vx += ax;
    vy += ay;
    super.update();
    
    ax = ay = 0;
    for(chargedParticle o : particles){
      if(o == this) continue;
      float dist2 = this.dist2(o); 
      if( dist2 < rTo2) {
        line(this.x,this.y,o.x,o.y);
        //attract(o);
        float mag = sqrt(dist2); 
        float fx = (this.x-o.x)*mag;
        float fy = (this.y-o.y)*mag;
        fx/= dist2;
        fy/= dist2;
        if(attraction){
          ax += fx;
          ay += fy;
        } else {
          ax -= fx;
          ay -= fy;
        }
      }
    }
    
    vx = drag*vx;
    vy = drag*vy;
    
  }  
}
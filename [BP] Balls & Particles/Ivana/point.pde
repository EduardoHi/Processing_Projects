class point {
  PVector p,v,a,prev;
  float max_f, max_v, size;
  color c;
  boolean del;
  
  point(){
    
    this( random(-half_w, width+half_w), random(-half_h, height+half_h), 0, 0, 0, 0);
  }
  
  point(float x, float y, float vx, float vy, float ax, float ay){
    p = new PVector(x, y);
    v = new PVector(vx, vy);
    a = new PVector(ax, ay);
    max_f = 0.3;
    max_v = 0.1;
    c = randomColor();
    del = false;
    size = random( 4, 20);
  }
  
  color randomColor(){

    if( random(1) < 0.5) {
        return lerpColor(dg, lg, random(1));    
    } else {
      return lerpColor(db, lb, random(1));
    }

    //return color( random(255), random(255), random(255) ); 
  }

  void update(){
    size *= 0.985;
    prev = p.copy();
    v.mult(0.98);
    p.add(v);
    v.add(a);
    a.mult(0);
  }
  
  void move(float x, float y){
    if( (p.x-x)*(p.x-x) + (p.y-y)*(p.y-y) < 100 || size < 0.5){
      del = true;
      return;
    }
    PVector desired = PVector.sub(new PVector(x,y), p);
    PVector steer = PVector.sub(desired, v);
    steer.normalize();
    steer.mult(max_v);
    steer.limit(max_f);
    a.add(steer);
  }

  void display(){
    fill(c);
    ellipse(p.x, p.y, size, size);
  }


}
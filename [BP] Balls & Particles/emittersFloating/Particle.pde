class Particle {
  int time;
  PVector pos;
  PVector vel;
  color c;
  
  Particle(PVector pos, color c){
    this.pos = pos;
    this.c = c;
    vel = PVector.random2D();
    time = lifespan;
  }
  
  void update(){
    pos.add(vel);
    vel.mult(.98);
    time--;
  }
  
  void display(){
    fill(c, 255 * (1.0*time/lifespan) );
    ellipse( pos.x, pos.y, 17, 17);
  }
  
}
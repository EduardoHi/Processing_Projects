class Bubble{
  PVector loc;
  PVector vel;
  color c;
  int radius;
  int timer;
  
  Bubble(float x, float y, PVector v, color c,int r){
    this.loc = new PVector(x,y);
    this.vel = v;
    this.c = c;
    timer = 5;
    radius = r;
  }
  // actualiza el timer y la posición
  void update(){
    timer--;
    loc.add(vel);
  }
  //checar si ya se acabo su vida
  void check(){
    if(timer<=0)bubbles.remove(this);
  }
  //pinta a la pantalla un bubble
  void display(){
    fill(c);
    noStroke();
    ellipse(loc.x,loc.y,radius,radius);
  }
}
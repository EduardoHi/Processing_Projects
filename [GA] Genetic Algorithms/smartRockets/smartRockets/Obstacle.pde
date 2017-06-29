class Obstacle {
  //PVector pos;
  //int w,h;
  Rectangle r;
  
  Obstacle(int x, int y, int w, int h){
    /*pos = new PVector(x,y);
    this.w = w;
    this.h = h;*/
    this.r = new Rectangle(x,y,w,h);
  }
  Obstacle(Rectangle r){
    this.r = r;
  }
  boolean checkCollision(float x, float y){
     if(r.contains((int)x,(int)y))
       return true;
     else
       return false;
  }
  void show(){
    if(r.width<5&&r.height<5)obs.remove(this);
    rectMode(CORNER);
    fill(175);
    rect(r.x,r.y,r.width,r.height);
  }
}
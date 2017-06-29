public class Intersection{
  PVector pos = new PVector(width/2,height/2);
  int w = 50;
  float r = sqrt(sq(w)*2)+10;
  
  void display(){
    noStroke();
    rectMode(CENTER);
    fill(120);
    rect(pos.x,pos.y, w , height);
    rect(pos.x,pos.y, width , w );
    pushMatrix();
      translate(width/2,height/2);
      rotate(PI/4);
      //fill(0);
      rect(0,0,r,r);
    popMatrix();
    
  }
}
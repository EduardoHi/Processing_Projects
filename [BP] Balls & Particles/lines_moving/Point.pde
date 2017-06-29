
class Point {
  PVector[] derivs;
  color c;
  
  Point(){
    derivs = new PVector[8];
    for(int i = 0; i<8; i++)
      derivs[i] = new PVector();
    
    derivs[0].x = random(width);
    derivs[0].y = random(height);
    
    c = color(random(255),random(255),random(255));
  }
  
  void updateKinematic(){
    derivs[5] = PVector.random2D().mult(0.001);
    
    for(int i = 5; i >0; i--){
       derivs[i-1].add(derivs[i].mult(0.94));
    }
    derivs[5].mult(0);
    
    //bounceWalls();
    wrapAround();
  }
  
  void bounceWalls(){
    if(derivs[0].x>width || derivs[0].x <0) derivs[1].x *= -1;
    if(derivs[0].y > height || derivs[0].y < 0) derivs[1].y *= -1;
  }
  
  void wrapAround(){
    if(derivs[0].x>width) derivs[0].x = 0;
    if(derivs[0].x <0) derivs[0].x = width;
    if(derivs[0].y > height) derivs[0].y = 0;
    if(derivs[0].y < 0) derivs[0].y = height;
  }
  
  void update(){
    updateKinematic();
    display();
  }
  
  void display(){
    fill(c);
    //ellipse(derivs[0].x,derivs[0].y, 20, 20);
    stroke(0,5);
  }
  
}
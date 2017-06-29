
float a = 0;

void setup(){
  
  size(800, 800, P3D);
   
  noFill();
  ortho();
  strokeWeight(2);
  
}

void draw(){
  background(0);
  translate(400, 400, 0);
  
  //rotateY(a+=PI/16);
  rotateX(PI/4);
  rotateZ(PI/4);
  stroke(255);
  box(200);
  
  sphere(3);
  
  stroke(240,10,10);
  //box(200);
}
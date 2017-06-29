int n = 1;
float A = 360/( pow( ( (sqrt(5)+1)/(2) ) , 2) );
float c = 6;

void setup(){
  A = radians(A);
  size (400,400);
  background(0);
  colorMode(HSB);
  noStroke();
}

void draw(){
  translate(width/2,height/2);
  float a = A*n;
  float r = c*sqrt(n);
  float x = r*cos(a);
  float y = r*sin(a);
  pushMatrix();
  translate(x,y);
  rotate(a-(PI/2));
  fill(r%256 , 255 , 255);
  ellipse(0,0,4,13);
  popMatrix();
  n++;
}
void keyTyped(){
if(key == 's'){
  saveFrame("###-phyllotaxis.png");
}
}
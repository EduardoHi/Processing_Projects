
float a;
int n;
color c;

void setup(){
  size(600,600);
  colorMode(HSB);
  noFill();
  a=0;
  n = 0;
  background(0);
  frameRate(60);
}

void draw(){
  
  //background(0);
  
  translate(width/2,height/2);  
  rotate(a);
  float cH = map(a,0,TWO_PI,0,255);
  c = color(cH,255,255);
  stroke(c);
  ellipse(0,0,(3*width)/4,height/3);
  
  
  a+= PI/500;
  if(a>=TWO_PI)a=0;
}
void keyTyped(){
  saveFrame("##.jpg");
}
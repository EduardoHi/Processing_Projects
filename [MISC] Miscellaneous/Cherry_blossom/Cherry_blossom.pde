//Cherry Tree
Tree t;
float maxAngle = PI/4;
//float oscMag = PI/512;
float wind;
float w = 0.1;
float Amp = PI/256;

color sky = #8DACDD;
color wood = #523E32;
color flower_1 = #E8DAE7;//#E49598;
color flower_2 = #DBADC0; //#BD6D4D;
color center = #EFAA7F;

void setup(){
  size(1280, 720);

  t = new Tree(50);
  frameRate(20);
}

void draw(){
  background(sky);
  
  translate(width/2, height*4/5.0);
  rotate(PI);
  
  fill(wood);
  stroke(wood);
  
  //wind = random(-oscMag,oscMag);
  wind = Amp*cos(w*frameCount);
  
  t.display();
  //if(frameCount%4==0) saveFrame("####.jpg");
}
  
void keyReleased(){
  t = new Tree(50);
}
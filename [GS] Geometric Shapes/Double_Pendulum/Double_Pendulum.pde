
float ox, oy, px, py;

boolean debug = false, recording = false;

Pendulo p;
Pendulo p2;

void setup(){

  size( 600, 600 );
  p = new Pendulo();
  
  background(250);
  stroke(0,20);
}

void draw(){

  translate(width/2, height/2);
  //for(int i=0; i<50; i++){
    p.update();
    p.display();
  //}
  
  if(recording)
    saveFrame("/movie/####.png");
}

void keyPressed(){
  if(key == 's')
    saveFrame("/frames/####.png");
  if(key == 'r')
    p = new Pendulo();
  if(key == 'c')
    background(240);
  if(key == 'd')
    debug = !debug;
  if(key == ' ')
    recording = !recording;
}

PImage img;
ArrayList<Bubble> bubbles;
boolean mouseDraw;

void setup(){
  size(1024,640,P2D);
  
  img = loadImage("sunset.jpg");
  img.resize(1024,640);
  bubbles = new ArrayList<Bubble>();
  mouseDraw = false;
  
  colorMode(HSB);
  img.loadPixels();
  background(img);
}


void draw(){
  //background(img);
  for(Bubble b: bubbles){
    b.update();
    b.display();
  }
  for(int i=0; i<bubbles.size(); i++){
    bubbles.get(i).check();
  }
  
  int speed = mouseDraw ? 3 : 50;
  for(int i=0; i<speed; i++){
    bubbly();
  }
}

//bubbly escoge la posición si pinta con el mouse o con random en toda la pantalla
void bubbly(){
  PVector offset = PVector.random2D();
  int radi = 15;
  offset.mult(radi);
  int x = 0;
  int y = 0;
  
  if(mouseDraw){
    x = (int)(mouseX+offset.x);
    y = (int)(mouseY+offset.y);
  } else {
    x = (int)(random(width)+offset.x);
    y = (int)(random(height-25)+offset.y);  
  }  
  
  createBubbleAt(x,y);
}

/*
función que crea una burbuja en la posición (x,y) especificada
escoje el color del pixel de su posición
le da un vector de velocidad random
*/
void createBubbleAt(int x, int y){
  
  if(x>width)x=width;
  if(x<0)x=0;
  if(y>height)y=height;
  if(y<0)y=0;
  
  color cb = img.pixels[x+(y*width)];
  noFill();
  stroke(0);
  
  int alpha = (int)random(100,255);
  cb = color (cb, alpha );
  
  int min = mouseDraw ? 10 : 3;
  int max = mouseDraw ? 50 : 15;
  int r = floor(random(min,max));
  
  PVector v = PVector.random2D();
  v.mult(random(0.5,2));
  
  bubbles.add(new Bubble(x,y, v , cb , r ));
}


void mouseReleased(){
  mouseDraw = !mouseDraw;
}
void keyTyped(){
  if(key=='s'){
    saveFrame("####.jpg");
  }
  if(key=='r'){
    background(img);
  }
}
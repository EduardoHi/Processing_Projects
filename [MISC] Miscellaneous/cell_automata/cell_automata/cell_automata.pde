import java.util.Arrays;
Map map;
boolean pause = false;

void setup(){

  size(800, 800);
  
  map = new Map(100, 100);
  
  frameRate(15);
  
  fill(0);
  noStroke();
}


void draw(){

  map.display();
  if(!pause)
   map.update();
  
  //saveFrame("frames//#####.png");
}

void keyPressed(){
  if( key == ' ' )
    pause = !pause;
  if( key == 'n' )
    map.update();
  if( key == 'r' )
    map = new Map(100, 100);
}

void mouseClicked(){
  map.turnOn(mouseX, mouseY);  
}

void mouseDragged(){
  map.turnOn(mouseX, mouseY);  
}
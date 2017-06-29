import java.util.*;

//controls
int camX, camY;
boolean debug = false;

float floor = 60;
float maxRand = 50;
float mutationRate = 0.1;
float costCoef = 10;
float energyPerLeaf = 10;

Population pop;
int popSize = 20;

void setup() {
  size(600, 600);
  camX = camY = 0;
  pop = new Population();
  pop.checkAllShadow();
  noStroke();
  frameRate(60);
}

void draw() {
  //translate(camX,camY);
  background(0);

  //floor
  noStroke();
  fill(100);
  rect(0, height-floor, width, height);
  
  //GUI
  fill(240);
  text(round(frameRate), 5, 15);
  text(pop.trees.size(), 5, 25);
  if(debug)text(mouseX+" , "+ mouseY, mouseX, mouseY);
  
  
  pop.run();
  pop.display();
  
}

void keyPressed() {
  /*
  if(key== 's')
   camY--;
   else if( key== 'w')
   camY++;
   
   if( key== 'a')
   camX++;
   else if( key == 'd')
   camX--;
   */
}

void keyReleased() {
  if ( key == 'd')
    debug = !debug;

  if (key == 'p') {
    pop.print();
  }
  if (key == 'r') {
    pop.randomize();
    pop.checkAllShadow();
  }
}

void mousePressed() {
  //pop.random();
}
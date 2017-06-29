Flower f;
Button nextGen;

int popSize = 10;
float mutationRate = 0.005;
int gen = 0;

Population pop;

Flower focusedF;
boolean focus = false;

void setup(){
  size (1200,600);
  colorMode(HSB,1.0);
  background(0.337,0.67,0.78);
  noStroke();
  smooth();
  pop = new Population();
  
  nextGen = new Button(width/2, 5*height/6 ,160,40,"next Gen");
}

void draw(){
  background(0.337,0.8,0.8);
  
  if(!focus){
    pop.display();
    pop.rollover(mouseX,mouseY);
    nextGen.display();
    nextGen.rollover(mouseX,mouseY);
  }else{
    focusedF.display();
  }
  
  textAlign(CENTER);
  fill(0);
  text("Generation #: " + gen ,width/2,50);
  
}

void mousePressed(){
  if (nextGen.clicked(mouseX,mouseY)) {
    pop.nextGen();
    gen++;
  }
  for(Flower f : pop.flowers){
    if(f.rolloverOn){
      focus = true;
      println(focus);
      focusedF = new Flower(f,width/2,height/2,3.5);
    }
  }
}
void mouseReleased() {
  nextGen.released();
  focus = false;
}
void keyPressed(){
  if(key=='r'){
    pop = new Population();
  }
}
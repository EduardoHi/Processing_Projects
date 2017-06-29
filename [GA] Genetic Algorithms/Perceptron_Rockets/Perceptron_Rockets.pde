int gen = 0;
int count = 0;

//ArrayList<Obstacle> obs;
PVector target;

int lifespan = 600;
int speed = 15;

boolean pause = false;
boolean drawG = true;

Population pop;

void setup(){
  size(600,600);
  reset();
  //obs = new ArrayList<Obstacle>();
  target = new PVector(width/2,50);
  pop = new Population();
}
void reset(){
  count = 0;
  gen = 0;
}
void draw(){
  background(0);
  fill(255);
  ellipse(target.x,target.y,10,10);
  /*
  for(Obstacle o : obs){
    o.show();
  }
  */
  if(speed<=0) pause = true;
  if(!pause){
    displayText();
    for(int i=0;i<speed;i++){
      pop.run();
      count++;
      //allInactive = true;
      
        for(Rocket r : pop.rockets){
          if(!(r.crashed||r.completed)){
          //allInactive = false;
          }
        }
      
      if(count==lifespan){//||allInactive){
        pop.nextGen();
        count = 0;
        gen++;
      }
      i++;
      }
  } else {
    displayText();
    pop.display();
  }
}
void displayText(){
  text("gen: "+gen,30,30);
  text("speed: "+speed,30,40);
  text("count: "+count,30,50);
}
void keyPressed(){
  if(key=='r'){
    reset();
  }
  if(key=='p'){
    pause = !pause;
  }
  if(key=='+'){
    if(speed<30)
    speed++;
  }
  if(key=='-'){
    if(speed>=1)
    speed--;
  }
  if(key=='g'){
    drawG = !drawG;
  }
}
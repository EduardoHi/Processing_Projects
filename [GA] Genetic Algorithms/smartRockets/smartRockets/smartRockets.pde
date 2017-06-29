import java.awt.Rectangle;

//counters
int gen = 0;
int count = 0;
int debug = 0;

//holders
Community comm;
ArrayList<Obstacle> obs;
PVector target;
Rectangle newObstacle = null;

//parameters
int lifespan = 600;
int speed = 15;

//controls
boolean pause = false;
boolean drawG = true;
boolean allInactive = true;

//stats
/*float avgFit = 0;
float bestFit = 0;
int bestTime = 0;*/

void setup(){
  size(600,600);
  reset();
  obs = new ArrayList<Obstacle>();
  target = new PVector(width/2,50);
}
void reset(){
  colorMode(HSB);
  comm = new Community();
  count = 0;
  gen = 0;
}
void draw(){
  background(0);
  fill(255);
  ellipse(target.x,target.y,10,10);
  rectMode(CORNER);
  fill(240);
  if(newObstacle!=null)rect(newObstacle.x, newObstacle.y, newObstacle.width, newObstacle.height);
  for(int i=0; i<obs.size(); i++){
    obs.get(i).show();
  }
  if(speed<=0) pause = true;
  if(!pause){
    displayText();
    for(int i=0;i<speed;i++){
      comm.run();
      count++;
      allInactive = true;
      for(Specie s : comm.species){
        for(Rocket r : s.rockets){
          if(!(r.crashed||r.completed)){
          allInactive = false;
          }
        }
      }   
      
      if(count==lifespan||allInactive){
        comm.nextGen();
        println("debug: "+debug);
        count = 0;
        gen++;
      }
      i++;
      }
  } else {
    displayText();
    comm.display();
  }
}

void displayText(){
  text("gen: "+gen,30,30);
  text("speed: "+speed,30,40);
  text("count: "+count,30,50);
  text("frameRate: "+(int)frameRate,30,60);
  //text("avg fit: "+(avgFit*1000),width-140,height-20);
  //text("best time: "+(bestTime),width-140,height-30);
}

void mouseReleased(){
  newObstacle.width = Math.abs(newObstacle.width);
  newObstacle.height = Math.abs(newObstacle.height);
  //newObstacle.x -= newObstacle.width;
  //newObstacle.y -= newObstacle.width;
  obs.add(new Obstacle(newObstacle));
  newObstacle = null;
}
void mouseClicked(){
  if(mouseButton==RIGHT){
    for(int i=0; i<obs.size(); i++){
      if( obs.get(i).checkCollision(mouseX,mouseY))
      obs.remove(i);
    }
  }
}
void mousePressed(){
  newObstacle = new Rectangle(mouseX,mouseY,0,0);
}
void mouseDragged(){
  newObstacle.width = mouseX-newObstacle.x; 
  newObstacle.height = mouseY-newObstacle.y;
}

void keyPressed(){
  if(key=='r'){
    reset();
  }
  if(key=='p'){
    pause = !pause;
  }
  if(key=='+'){
    //if(speed<30)
    if(key==SHIFT){
      speed += 50;
    }else{
      speed++;
    }
  }
  if(key=='-'){
    if(speed>=1){
      if(key==SHIFT){
        speed-=50;
      }else{
        speed--;
      }
    }
  }
  if(key=='g'){
    drawG = !drawG;
  }
  if(key=='c'){
    obs.clear();
  }
}
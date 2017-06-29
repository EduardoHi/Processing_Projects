Intersection inter;

Population pop;

int generation = 0;

int speed = 2;

int lifespan = 5000;//10000; // daylength
int count = 0;
int turn = 0;

int currentSim = 0;

boolean displayingBest = false;

float mutationRate = 0.005;
float spawnRate = 0.05;
int[] schedule = new int[lifespan];

void setup(){
  size(600,600);
  generateSchedule();
  pop = new Population();
  inter = new Intersection();
}
void generateSchedule(){
    for(int i=0; i<lifespan; i++){
      int rndm = floor(random(0,3));
      float a=0,b=2;
      if(rndm==0){
        b = 1.2;
      } else if(rndm==1){
        a=0.8;
      }    
      int carD = floor(random(a,b));
      if(random(1)<spawnRate) schedule[i] = carD;
      else schedule[i] = -1;
    }
}
void draw(){
  
  background(30);
  turn = count/200;
  fill(230);
  text("turn: "+turn,20,20);
  text("count: "+count,20,40);
  text("generation: "+generation,20,60);
  text("speed: "+speed,20,80);
  noStroke();
  fill(0,0,255);
  ellipse(width/2+40,20,20,20);
  fill(0,255,0);
  ellipse(width-20,height/2+40,20,20);
  inter.display();
  for( int i=0; i<speed; i++){
    if(displayingBest){
      pop.bestSim.displayed = true;
    }
    
    pop.run();
    
    count++;
    if(count==lifespan){
      count = 0;
      displayingBest = false;
      pop.bestSim.displayed = false;
      generation++;
      pop.nextGen();
    }
  }
}

void keyTyped(){
  if(key=='b'){
    displayingBest = !displayingBest;
    speed = 1;
  }
  if(key=='r'){
    count = 0;
    generation = 0;
    generateSchedule();
    pop = new Population();
  }
  if(key=='+'){
    speed++;
  }
  if(key=='-'){
    if(speed>0){
      speed--;
    }
  }
}
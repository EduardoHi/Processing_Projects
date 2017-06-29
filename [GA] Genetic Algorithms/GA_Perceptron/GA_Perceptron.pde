Population pop;

int nPoints = 2000;
Trainer[] training = new Trainer[nPoints];
int gen = 0;
Perceptron Best;
float xmin = -400;
float ymin = -100;
float xmax =  400;
float ymax =  100;

int count = 0;

float f(float x)  {
  float a = 0.4;
  float b = 1;
  return a*x + b;
}

void setup(){
  Best = new Perceptron();
  size(640,360);
  background(10);
  pop = new Population();
  
  reset();
  smooth();
}
void reset(){
  for (int i = 0; i < training.length; i++) {
    float x = random(xmin, xmax);
    float y = random(ymin, ymax);
    int answer = 1;
    if (y < f(x)) answer = -1;
    training[i] = new Trainer(x, y, answer);
  }
}
void draw(){
  drawLine();
  fill(10);
  text(gen,-width/2+20,-height/2+20);
  
  boolean drawn = false;
  for(int i=0; i< 100; i++){
    boolean drawing = false;
    if(i==0)drawing = true;
    pop.run(drawing);
    if(gen!=0&&!drawn){
      Best.display(true);
      drawn = true;
    }
    if(count==nPoints-1){
      pop.displayStats();
      println("Best´s Score: "+Best.score);
      pop.nextGen(); 
      gen++;
      count = 0;
      reset();
    }
    count++;
  }
}
void drawLine(){
  background(255);
  translate(width/2,height/2);
  strokeWeight(4);
  stroke(127);
  line(xmin,ymin,xmax,ymax);
}
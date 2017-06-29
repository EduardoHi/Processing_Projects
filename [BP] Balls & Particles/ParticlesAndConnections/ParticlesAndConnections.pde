
int r = 200;
float rTo2;
int maxVel = 1;
float maxAcc = 0.2;
float drag = 0.98;
boolean attraction = false;

int N = 10;
ArrayList<chargedParticle> particles;

void setup(){
  fullScreen();
  
   rTo2 = r*r;
  
  particles = new ArrayList<chargedParticle>(N);
  int i = 0;
  while(i++<100)
    particles.add(new chargedParticle());
  
  fill(255);
  stroke(255,100);
}

void draw(){
  background(0);
  for(chargedParticle p : particles){
    p.update();
    p.display();
  }
  
  //if(frameCount% 3*60 == 0) attraction = !attraction;
 
 //saveFrame("\\output\\###.png");
}


void mouseClicked(){
  attraction = !attraction;
}

void keyPressed(){
  if(key == UP){
    r++;
  } else if( key == DOWN){
    r--;
  } else if( key == 's'){
    saveFrame("\\output\\###.png");
  }
  
}
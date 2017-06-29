
int n = 10;

ArrayList<Ball> balls;

void setup(){
  size(600,600);
  background(0);
  noStroke();
  
  balls = new ArrayList<Ball>();
  
  
  for( int i=0; i<n; i++){
    balls.add( new Ball() );
  }
  
}

void draw(){
  background(0);
  for(Ball b: balls){
    b.display();
    b.applyForce(PVector.random2D().setMag(10));
    b.update();
  }
}

void checkCollisions(){
  for(Ball a: balls){
    for(Ball b: balls){
      if(a.equals(b)) continue;
      float d = sqrt( pow((a.p.x-b.p.x),2) + pow((a.p.y-b.p.y),2) );
      //if(d<= a.r+b.r)
      
    }
  }
  
}


void mouseReleased(){
  balls.add( new Ball() );
}
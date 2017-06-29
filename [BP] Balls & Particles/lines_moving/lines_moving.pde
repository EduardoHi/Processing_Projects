

 
int lifespan = 50;
int N = 4;
Point[] points;
int steps = 10;

void setup(){
  
  size(1000,1000);
  //fullScreen();
  
  //frameRate(15);
  
  points = new Point[N];//new ArrayList<Point>(N);
  for(int i = 0; i<N ; i++){
    points[i] = new Point();
  }
  
  stroke(0,5);
  background(255);
}


void draw(){
  //background(255);
  
  for(int i = 0; i< points.length; i++)
    points[i].update();
 
  linesBetween();
  
}

void keyPressed(){
  if(key == 'r'){
  }
} 


void linesBetween(){
  
  PVector origin = points[0].derivs[0].copy();
  translate(origin.x, origin.y);
  
  pushMatrix();
  PVector A = PVector.sub( points[1].derivs[0], points[0].derivs[0] );
  line(0,0, A.x, A.y);
  translate(A.x, A.y);
  PVector B = PVector.sub( points[2].derivs[0], points[1].derivs[0] );
  line(0,0, B.x, B.y);
  translate(B.x, B.y);
  PVector C = PVector.sub( points[3].derivs[0], points[2].derivs[0] );
  line(0,0, C.x, C.y);
  translate(C.x, C.y);
  PVector D = PVector.sub( points[0].derivs[0], points[3].derivs[0] );
  line(0,0, D.x, D.y);
  translate(D.x, D.y);
  popMatrix();
  PVector stepD = D.copy().div(steps).mult(-1);
  PVector stepB = B.copy().div(steps);
  for(int i=0; i<steps; i++){
    float x1 = stepD.x * i;
    float y1 = stepD.y * i;
    float x2 = A.x + stepB.x * i;
    float y2 = A.y + stepB.y * i;
    line( x1, y1, x2, y2 ); 
  }
}
  
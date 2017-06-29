
color cyan = #38ede4; // cyan
color black_cyan = #0f0f20; // black cyan

color magenta = #883185;
color white_magenta = #bec1ec;

float a = ( 360/( pow( ( (sqrt(5)+1)/(2) ) , 2) ) )*PI/180 ;
float c = 10;
float n = 1;

void setup(){
  
  size(400,400);
  
  noStroke();
  
  background(0);
  
}

void draw(){

  float angle = a*n;
  float r = c*sqrt(n);
  
  float x = r*cos(angle);
  float y = r*sin(angle);
  
  drawArc( x , y);
  
  n+=1;
  
  if(n%2==0)
      saveFrame("###.gif");
}



void drawArc( float x, float y){
  translate(width/2, width/2);
  
  float difX = x-0;
  float difY = y-0;
  float dist = sqrt( (difX*difX) + (difY*difY) );
  
  color c1 = lerpColor( black_cyan , cyan , map(dist, 0, sqrt(width*width/2) , 0, 1 ) );  
  
  color c2 = lerpColor( white_magenta , magenta , noise(y) );
  
  fill( lerpColor ( c1, c2, 0.2 ) ); 
  
  
  ellipse( x, y, 15, 15 );
  
}

void keyPressed(){
  if(key=='s'){
    saveFrame("###.gif");
  }
}
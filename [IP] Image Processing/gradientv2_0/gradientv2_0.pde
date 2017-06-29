color l_green = #728f18;
color d_green = #154016;
color l_brown = #a97b1d;

color c1;
color c2;

float maxDiag = 1;
int h2 = 1;

int crazeN = 2000;

boolean inv = false;

PVector origin = new PVector(0,0);

void setup(){
  size(700,700);
  
  h2 = height/2;
  origin = new PVector(width/2, height/2);
  maxDiag = distToO(0, 0);
  
  c1 = color(random(255) , random (255) , random (255) );
  c2 = color(random(255) , random (255) , random (255) );
  generateGradient();
}

void draw(){
  
}
void randomGradient(){
  c1 = color(random(255) , random (255) , random (255) );
  c2 = color(random(255) , random (255) , random (255) );
  generateGradient();
}

void generateGradient(){  
  loadPixels();
  
  for(int y = 0; y<height; y++){
    for(int x = 0; x<width; x++){
        float t = factorT(inv, x, y, gradientType.ANGULAR );
        color inter = interColor(c1 , c2, t, fx.LINEAL );
        pixels[y*width + x] = inter;
    }
  }
  
  updatePixels();
  
}

color interColor(color a, color b, float t, fx fxType){
  float ra = red(a);
  float rb = red(b);
  float ga = green(a);
  float gb = green(b);
  float ba = blue(a);
  float bb = blue(b);
  
  float R = 0,G = 0,B = 0;
  switch (fxType){
    case LINEAL :
    R = lineal(ra,rb,t);
    G = lineal(ga,gb,t);
    B = lineal(ba,bb,t);
    break;
    case EXP :
    R = expo(ra,rb,t);
    G = expo(ga,gb,t);
    B = expo(ba,bb,t);
    break;
    case SQUARED :
    R = squared(ra,rb,t);
    G = squared(ga,gb,t);
    B = squared(ba,bb,t);
    break;
    case SQROOT :
    R = sqroot(ra,rb,t);
    G = sqroot(ga,gb,t);
    B = sqroot(ba,bb,t);
    break;
    case HALF_CIRCLE :
    R = halfCircle(ra,rb,t);
    G = halfCircle(ga,gb,t);
    B = halfCircle(ba,bb,t);
    break;
    case QUARTER_CIRCLE :
    R = quarterCircle(ra,rb,t);
    G = quarterCircle(ga,gb,t);
    B = quarterCircle(ba,bb,t);
    break;
    case SIN :
    R = sin(ra,rb,t);
    G = sin(ga,gb,t);
    B = sin(ba,bb,t);
    break;
    case COS :
    R = cos(ra,rb,t);
    G = cos(ga,gb,t);
    B = cos(ba,bb,t);
    break;
    case TAN :
    R = tan(ra,rb,t);
    G = tan(ga,gb,t);
    B = tan(ba,bb,t);
    break;
    case SIGMOID :
    R = sigm(ra,rb,t);
    G = sigm(ga,gb,t);
    B = sigm(ba,bb,t);
    break;
    case LOG :
    R = log(ra,rb,t);
    G = log(ga,gb,t);
    B = log(ba,bb,t);
    break;
  }
  return color(R,G,B);  
}

float log(float v0, float v1, float t){
  return v0 + (v1 - v0)*log(9*t+1);
}

float sigm(float v0, float v1, float t){
  return (v0 + v1)/2 + ((v1 - v0)) /( ( 1+exp(6*(t-0.5)) ) ); 
}

float rational(float v0, float v1, float t){
  return v0 + (v1-v0)/(1-t); 
}

float lineal(float v0, float v1, float t){
  return v0 + t*(v1-v0);
}

float expo(float v0, float v1, float t){
  return v0 + (v1-v0)*(exp(t)-1);
}

float squared(float v0, float v1, float t){
  return (1-t)*v0 + (v1)*t*t;
}

float sqroot(float v0, float v1, float t){
  return v0 + (v1 - v0)*sqrt(t);
}

float halfCircle(float v0, float v1, float t){
  return v0 + (v1 - v0)*sqrt( t*(4 - 4*t) );
}
float quarterCircle(float v0, float v1, float t){
  return v0 + (v1 - v0)*sqrt( t*(2 - t) ); 
}

float sin(float v0, float v1, float t){
  return (v0 + v1)/2 + (v1 - v0) * sin(t*TWO_PI)/2;
}

float cos(float v0, float v1, float t){
  return (v0 + v1)/2 + (v1 - v0) * cos(t*TWO_PI)/2; 
}

float tan(float v0, float v1, float t){
  return (v0 + v1)/2 + (v1 - v0) * tan(t*TWO_PI)/2;
}



float p2pDist(float x1, float y1, float x2, float y2){
  return sqrt( (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2)); 
}

float distToO(int x, int y){
  return p2pDist(x, y, origin.x, origin.y );
}

float distToL(int x, int y){
  float up = abs( height*x - width*y );
  return up/p2pDist(0,700,700,0);
}

float factorT(boolean inv, int x, int y , gradientType t){
  float d = 0; 
  if(t == gradientType.RADIAL){
    d = distToO(x,y)/maxDiag;
  }
  else if( t == gradientType.DIAGONAL){
    d = distToL(x,y)/maxDiag;
  }
  else if( t == gradientType.LINEAL){
    d = 1.0*x/width;
  }
  else if( t == gradientType.ANGULAR){
    float dx = (x-origin.x);
    float dy = (y-origin.y);
    d = atan2(dy, dx);
    d /= TWO_PI;  
  }
  return inv ? 1 - d : d;
}

enum gradientType{
  RADIAL, DIAGONAL, ANGULAR, LINEAL;
}

enum fx {
  EXP, LINEAL, SQUARED , SQROOT, HALF_CIRCLE, QUARTER_CIRCLE,
  SIGMOID, SIN, COS, TAN, LOG;
}

void keyPressed(){
  if(key == 's' || key == 'S')
    saveFrame("\\capitulo\\####.png");
  else if(key == 'r' || key == 'R')
    randomGradient();
    
}

void mouseClicked(){
  inv = !inv;
  generateGradient();
}
color c;
int n;
float a;

void setup(){
  size(600,600);
  background(0);
  colorMode(HSB);
  n = 0;
  a= 0;
}

void draw(){
  //background(0);
  c = color(n%255,255,255);
  pushMatrix();
    a = random(10);
    float angle = map(a,0,10,0,TWO_PI);
    translate(width/2,height/2);
    float colorH = map(a,0,10,0,255);
    c = color(colorH,255,255);
    fill(c);
    stroke(c);
    //strokeWeight(2);
    float x = 200*cos(angle);
    float y = 200*sin(angle);
    line(0,0,x,y);
  popMatrix();
  n++;
}
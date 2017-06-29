
float half_w;
float half_h;
float r1 = 400;
float r2 = 1;
PShape circle;

ArrayList<point> points = new ArrayList<point>();

color dg = #326400;
color lg = #58b100;
color db = #58b100;
color lb = #1a1aff;

void setup(){

  //size(900,900);
  fullScreen();
  half_w = width/2;
  half_h = height/2;
  for(int i=0; i<5; i++)
    points.add(new point());
  noStroke();
  //background(#152900);
  background(0);
}

void draw(){
  
  for(int i=0; i<10; i++)
    points.add(new point());
  
  //background(0);
  
  for (point p : points){
    p.move( width/2, height/2 );
    p.update();
    p.display();
  }
  
  for(int i=0; i<points.size(); i++){
    if(points.get(i).del == true)
      points.remove(i);
  }
  
  
  
  fill(0,10);  
  ellipse(half_w, half_h, r1, r1);
  
  r1 *= 1.001;
  r2 += 2;
  
  saveFrame("frames//#####.png");
}
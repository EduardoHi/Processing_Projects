
Curve[] curves;
int n=25;
float amp = 1.7;
float Xseparation;
int points = 100;

void setup(){
  size(600,600);
  Xseparation = width/(points);
  reset();
}

void draw(){ //<>//
  background(0);
  for(int i=0; i<n; i++){
    curves[i].display();
  }
}
void reset(){
  curves = new Curve[n];
  curves[0] = new Curve(width/100,(48*height)/50);
  
  for(int i=1; i<=(n-1); i++){
    curves[i] = new Curve(curves[i-1],amp);
  }
  
  background(0);
}

void keyTyped(){
  if(key=='s'){
    saveFrame("##.jpg");
  }else{
  reset();
  }
}

void setup(){

  size(800, 800);
  background(0);
  noFill();
  
  stroke(255);
  
  translate(400, 500);
  for(int i=0; i<6; i++){
    translate(0,-40);
    rombo();
  }

}


void rombo(){
  beginShape();
  vertex( -180 + r(), 0 );
  vertex( 0 , 200 + r());
  vertex( 180 + r(), 0 );
  vertex( 0 , -157 + r());
  endShape(CLOSE);
}

float r(){
  return random(-13, 13);
}
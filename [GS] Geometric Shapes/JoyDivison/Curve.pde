class Curve{
  PVector start;
  float[] h;
  
  Curve( float x, float y){
    start = new PVector(x,y);
    h = new float[points];
    
    for(int i=0; i<points; i++){
      h[i] = 0;
    }
  }
  Curve(Curve c,float amp){
    this(c.start.x ,c.start.y-20);
    for(int i=0; i<points; i++){
      this.h[i] = c.h[i]+= random(-amp,amp);
    }
  }

  void display(){
    pushMatrix();
    translate(start.x,start.y);
    
    stroke(255);
    strokeWeight(1);
    noFill();
    beginShape();
    vertex(0,0);
    for(int i=0; i<points; i++){
      curveVertex(Xseparation*(i+1) , h[i]);
    }
    endShape();
    popMatrix();
    
    //start.y++;
  }
}
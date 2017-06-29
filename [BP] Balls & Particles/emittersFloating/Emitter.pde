
class Emitter {
  ArrayList<Particle> particles;
  PVector[] derivs;
  color c;
  
  Emitter(){
    particles = new ArrayList<Particle>();
    derivs = new PVector[8];
    for(int i = 0; i<8; i++)
      derivs[i] = new PVector();
    
    derivs[0].x = width/2;
    derivs[0].y = height/2;
    
    c = color(random(255),random(255),random(255));
  }
  
  void addBall(PVector pos, color c){
    particles.add(new Particle(pos , c));
  }
  
  void updateKinematic(){
    derivs[5] = PVector.random2D().mult(0.001);
    
    for(int i = 5; i >0; i--){
       derivs[i-1].add(derivs[i].mult(0.94));
    }
    derivs[5].mult(0);
    
    if(derivs[0].x>width) derivs[0].x = 0;
    if(derivs[0].x <0) derivs[0].x = width;
    if(derivs[0].y > height) derivs[0].y = 0;
    if(derivs[0].y < 0) derivs[0].y = height; 
  }
  
  void update(){
    updateKinematic();
    
    fill(c);
    ellipse(derivs[0].x,derivs[0].y, 20, 20);
    addBall( new PVector(derivs[0].x, derivs[0].y), c );
    
    for(Particle p : particles){
      p.update();
      p.display();
    }
    kill();
  }
  
  void kill(){
    for(int i=0; i<particles.size(); i++){
      if(particles.get(i).time <=0) particles.remove(i);
    }
  }
  
}
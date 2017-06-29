

float maxVel = 5;
float maxAcc = 4;

float ecc = 0;
float p = 100;

float e_loss = 0.80;
float friction = 0.995;

//float G_CONST = 6.67408E-11;
float G_CONST = 1;

boolean deb = false;

//ArrayList<Particles>

Particle sol;
Particle planet;

void setup(){
  size(600,600);
  
  
  sol = new Particle(200, width/2, height/2);
  planet = new Particle(100);
  
  noStroke();
}


void draw(){
  background(0,60);
  //for(int i=0; i<100; i++){
    
    sol.display(color(13, 50, 210));
    planet.display(color(130, 10, 20));
    sol.update(planet);
    planet.update(sol);
  //}
  gravity(sol, planet);
}

void gravity(Particle a, Particle b){
  float dx = a.x - b.x;
  float dy = a.y - b.y;
  float d2 = b.dist2(a);
  float d = sqrt(d2);
  if( b.collisions(a) ) return;
  dx/= d;
  dy/= d;
  
  float f = G_CONST*b.mass*a.mass/d2;    
  float fx = f*dx;
  float fy = f*dy;
  
  b.applyForce(fx,fy);
  a.applyForce(-fx,-fy);
  
}

void mouseClicked(){
  deb = !deb;
}


 
int lifespan = 50;
int N = 10;
ArrayList<Emitter> emitters;

void setup(){
  //size(1000,1000);
  fullScreen();
  
  emitters = new ArrayList<Emitter>(N);
  for(int i = 0; i<N ; i++){
    emitters.add(new Emitter() );
  }
  
  noStroke();
}


void draw(){
  background(0,15);
  
  for(Emitter e : emitters)
    e.update();
  
}

void keyPressed(){
  if(key == 'r'){
  }
} 


float calcularPromedio(int[] datos){
  float n = 0;
  
  //for each
  for(int i : datos){
    n+= i;
  }
  
  return ( 1.0*n/N );
}
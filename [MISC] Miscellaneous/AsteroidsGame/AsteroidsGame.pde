

ArrayList<Asteroid> asteroids;
Spaceship ship;

void setup(){
  size(600,600);
  
  asteroids = new ArrayList<Asteroid>();
  for(int i=0; i<5; i++){
    asteroids.add( new Asteroid(PVector.random2D()) );
  }
  
  ship = new Spaceship();
}

void draw(){
  background(0);
  
  
  println(millis()/1000);
  for(int i=0; i<asteroids.size(); i++){
    asteroids.get(i).display();
    asteroids.get(i).seek(ship.loc);
    asteroids.get(i).update();
  }
  
  ship.update();
  ship.checkCollisions();
  ship.wrapEdges();
  ship.display();
  
  if(keyPressed) {
    if(keyCode == LEFT){
      ship.turn(-0.03);
    }
    if(keyCode == RIGHT){
      ship.turn(0.03);
    }
    if(key==' '){
      ship.thrust(1);
    }
  }
}
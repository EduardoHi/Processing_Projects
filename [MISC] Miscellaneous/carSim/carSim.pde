Car[] cars;
int n;

PVector target = new PVector(300,400);

void setup(){
  size(600,600);
  n = 10;
  cars = new Car[n];
  
  for(int i=0; i<n; i++){
    cars[i] = new Car(random(width),random(height),random(1,4));
  }
}

void draw(){
  target = new PVector(mouseX,mouseY);
  background(0);
  for(Car c : cars){
    if(c.dist2(target)<10)
      c.reached = true;
      
    c.seek(target);
    c.move();
    c.display();
  }
  
  fill(240,30,30);
  ellipse(target.x,target.y,20,20);
}
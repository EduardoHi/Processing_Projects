class Sim {
  ArrayList<Car> cars;
  Semaforo sem;
  Intersection inter;
  int totalWaitTime = 0;
  int totalCompleted = 0;
  int totalCrashes = 0;
  boolean displayed = false;
  
  Sim(Semaforo sem){
    cars = new ArrayList<Car>();
    this.sem = sem;
  }
  void displayStats(){
    println("total crashes: "+totalCrashes);//,20,80);
    println("total completed: "+totalCompleted);//,20,100);
    println("total wait time: "+totalWaitTime);//,20,60);
    println("fitness: "+sem.fitness);
    println("Norm fitness: "+sem.normFit);
  }

  void run(){
    if( !(schedule[count]<0) ){
      cars.add(new Car(schedule[count]));
    }
    for(int i=0; i< cars.size() ; i++){
      totalWaitTime += cars.get(i).waitingTime;
      
      //displayed = false;
      if(displayed){
        cars.get(i).run();
      }else{
        cars.get(i).update();
      }
    }
    sem.update();
    if(displayed)sem.display();
  }
}
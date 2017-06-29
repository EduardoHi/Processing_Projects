class Flower{
  
  DNA dna;
  PVector[] petal = new PVector[6];
  PVector[] sepal = new PVector[6];
  PVector[] stamen = new PVector[5];
  int numPetals,numSepals,numStamens;
  float petalA,sepalA,stamenA;
  int petalC,sepalC,stamenC;
  
  Rectangle r;
  float fitness;
  boolean rolloverOn;
  boolean drawP,drawSe,drawSt;
  float x,y;
  int wh;
  float scale=1;
  
  Flower(Flower copy,int x,int y ,float scale){
    fitness = copy.fitness;
    this.x = x;
    this.y = y;
    this.wh = copy.wh;
    this.scale = scale;
    this.dna = copy.dna;
    drawP = drawSe = drawSt = true;
    setPhenotype();
    r = copy.r;
  }
  
  Flower(DNA dna,float x, float y){
    fitness = 1;
    this.x = x;
    this.y = y;
    this.wh = (width-(50*popSize))/popSize;
    this.dna = dna;
    drawP = drawSe = drawSt = true;
    setPhenotype();
    r = new Rectangle(int(x-wh/2), int(y-wh/2), int(1.5*wh), int(1.5*wh));
  }
  
  void setPhenotype(){
    petal[0] = new PVector(0,0);
    sepal[0] = new PVector(0,0);
    
    for(int i=1; i <= 9 ; i+=2){
      petal[ceil(i/2.0)] = new PVector(dna.genes[i-1],dna.genes[i]);
      sepal[ceil(i/2.0)] = new PVector(dna.genes[10+i-1],dna.genes[10+i]);
      stamen[ceil(i/2.0)-1] = new PVector(dna.genes[20+i-1],dna.genes[20+i]);
    }

    numPetals = floor(dna.genes[30]);
    numSepals = floor(dna.genes[31]);
    numStamens = floor(dna.genes[32]);
    
    this.petalC = color(dna.genes[33]  ,1,1);
    this.sepalC = color(dna.genes[34]  ,1,1);
    this.stamenC = color(dna.genes[35]  ,1,1);
    
    this.petalA = TAU/numPetals;
    this.sepalA = TAU/numSepals;
    this.stamenA = TAU/numStamens;
  }
  void drawFlower(int scale){
    pushMatrix();
      translate(x,y);
      scale(this.scale*scale,this.scale*scale);
      
      strokeWeight(1);
      stroke(255);
      if(drawSe){
        //all sepals
        fill(sepalC);
        for(int i=0;i<numSepals ;i++){
          //each sepal
          pushMatrix();
           rotate(sepalA*i);
           beginShape();
           vertex(sepal[0].x , sepal[0].y);
           bezierVertex(sepal[1].x, sepal[1].y,
                        sepal[2].x, sepal[2].y,
                        sepal[3].x, sepal[3].y);
           bezierVertex(sepal[4].x, sepal[4].y,
                        sepal[5].x, sepal[5].y,
                        sepal[0].x, sepal[0].y);
           endShape();
          popMatrix();
        }
      }
      if(drawP){
        //all petals
        fill(petalC);
        for(int i=0;i<numPetals ;i++){
          //each petal
          pushMatrix();
           rotate(petalA*i);
           beginShape();
           vertex(petal[0].x , petal[0].y);
           bezierVertex(petal[1].x, petal[1].y,
                        petal[2].x, petal[2].y,
                        petal[3].x, petal[3].y);
           bezierVertex(petal[4].x, petal[4].y,
                        petal[5].x, petal[5].y,
                        petal[0].x, petal[0].y);
           endShape();
           
           popMatrix();
        }
      }
      if(drawSt){
        //all stamens
        fill(stamenC);
        for(int i=0; i<numStamens ;i++){
          pushMatrix();
            rotate(stamenA*i);
            scale(0.2,0.2);
            translate(0, stamen[0].mag());
            beginShape();
            
              curveVertex(stamen[1].x,stamen[1].y);
              for(int j=1; j<5; j++){
                curveVertex(stamen[j].x,stamen[j].y);
              }
              curveVertex(stamen[1].x,stamen[1].y);
              curveVertex(stamen[1].x,stamen[1].y);
            endShape();
          popMatrix();
        }
      }
      popMatrix();
  }
  
  void display(){
    
    drawFlower(wh);
    pushMatrix();
    
    translate(x,y);

    textAlign(CENTER);
    if (rolloverOn) fill(0);
    else fill(0.15);
    text(int(fitness), 0, wh+3);
   
     popMatrix();
  }
  void rollover(int mx, int my) {
    if (r.contains(mx, my)) {
      rolloverOn = true;
      fitness += 0.5;
      scale = 2;
    } else {
      rolloverOn = false;
      scale = 1;
    }
  }
}
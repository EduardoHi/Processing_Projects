class Perceptron {
  float[] weights;
  int score;
  double fitness;
  color c;
  DNA dna;
  
  Perceptron() {
    score = 0;
    c = color(random(255) , random(255) , random(255));
    dna = new DNA();
    weights = new float[3];
    for (int i = 0; i < weights.length; i++) {
      weights[i] = dna.genes[i];
    }
  }
  Perceptron(Perceptron p){
  this.weights = p.weights;
  this.score = p.score;
  this.dna = p.dna;
  this.fitness = p.fitness;
  this.c = p.c;
  }
  Perceptron(DNA dna,color c){
     score=0;
     this.c = c;
     this.dna = dna; 
     weights = new float[3];
     for (int i = 0; i < weights.length; i++) {
       weights[i] = this.dna.genes[i];
     }
  }
  
  int feedforward(float[] inputs) {
    float sum = 0;
    for (int i = 0; i < weights.length; i++) {
      sum += inputs[i]*weights[i];
    }
    return activate(sum);
  }
   int activate(float sum) {
    if (sum > 0) return 1;
    else return -1;
  }
  void display(boolean points){
    stroke(c);
    strokeWeight(1);
    float x1 = xmin;
    float y1 = (-weights[2] - weights[0]*x1)/weights[1];
    float x2 = xmax;
    float y2 = (-weights[2] - weights[0]*x2)/weights[1];
    line(x1,y1,x2,y2); 
    
    if(points){
      for (int i = 0; i < count; i++) {
        noStroke();
        int guess = feedforward(training[i].inputs);
        if (guess > 0) {
          noFill();
          stroke(0);
          strokeWeight(1);
        } else{
          fill(c);
        }
        ellipse(training[i].inputs[0], training[i].inputs[1], 8, 8);
      }
    }
  }
  void updateScore(int desired){
    int guess = feedforward(training[count].inputs);
    if( desired==guess ){
      score++;
    }
  }
  void printW(){
   for(int i=0; i<3 ;i++){
     print(weights[i]+",");
   }
   println();
  }
}
class Perceptron {
   float[] weights;
  DNA dna;
  
  Perceptron() {
    dna = new DNA();
    weights = new float[3];
    for (int i = 0; i < weights.length; i++) {
      weights[i] = dna.genes[i];
    }
  }
  
  Perceptron(Perceptron p){
    this.weights = p.weights;
    this.dna = p.dna;
  }
  
  Perceptron(DNA dna){
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
  
}
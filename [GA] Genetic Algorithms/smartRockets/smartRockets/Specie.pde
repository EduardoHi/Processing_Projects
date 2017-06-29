class Specie extends Population{
  float [] fitnessFun;
  color c;
  Specie(color c , float[] f){
    super();
    this.c = c;
    fitnessFun = f;
    for(Rocket r: rockets){
      r.c = this.c;
    }
  }
  void evaluate(){
    super.evaluate(fitnessFun);
    println(fitnessFun);
  }
}
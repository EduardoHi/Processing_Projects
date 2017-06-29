import processing.serial.*;

Serial myPort;
String line1;
String line2;
int num = 400;
int index = 0;
float[] Yvalues;

void setup() {
  
  size(800,400);
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  
  Yvalues = new float[num];
  
  colorMode(HSB,100);
}

void draw()
{ 
  drawBack();
  
  if ( myPort.available() > 0) 
  {  // If data is available,
  line1 = myPort.readStringUntil('\n');
  line2 = myPort.readStringUntil('\n'); // read it and store it in val
  } 
  
  
  if(line1!=null&&line2!=null){
    for(int i=1; i<Yvalues.length; i++){
      Yvalues[i-1] = Yvalues[i];
    }
    Yvalues[Yvalues.length-1] = 100*float(line2);
  }
  
  translate(0,height/2);
  //scale(2,2);
  println(line2);
  
  
  stroke(100,100,100);
  for(int i=1; i<Yvalues.length; i++){
    //point( i , -Yvalues[i] );
    line( i-1 , -Yvalues[i-1] , i , -Yvalues[i]);
  }
  
  fill(100,Yvalues[num-1],100);
  rect(num,0,30,-Yvalues[num-1]);
  fill(0);
  text(Yvalues[num-1], num , -120);
  stroke(0);
  line( num+50, 0, num+50, -100);
  
}

void drawBack(){
  background(100);
  stroke(0);
  line(0,height/2,width,height/2);
}
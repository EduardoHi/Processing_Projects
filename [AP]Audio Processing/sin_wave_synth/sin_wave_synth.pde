import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Oscil testTone;
AudioOutput out;
Minim mn;

float fq = 20;
float fv = 1;

void setup(){
  testTone = new Oscil( 440, 1, Waves.SINE );
  mn = new Minim( this );
  
  out = mn.getLineOut(Minim.STEREO);
  
  //  testTone.patch(out);
  
  testTone.setFrequency( 2000 );
  
  size(1000,400);
}

void draw(){
  background(0);
  fq = (1.0*mouseX/width)*20000;
  testTone.setFrequency( fq );
  
  //fq+=fv;
  
  if(fq>20000){
    fv *= -1;
  } else if (fq < 20){
    fv *= -1;
  }
  
  text(fq,20, 20);
}

void keyPressed(){
  out.playNote("A4");
}
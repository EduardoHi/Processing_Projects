import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;
BeatDetect beat;

int eX = 10;
int eY = 10;
boolean mute = false;
color color_1 = #ECD078; //#013f2f; //#e65a90; //#78d8a9;
color color_2 = #C02942; //#cb07e7; //#62519b; //#d698fd;
color color_3 = #542437;
color color_4 = #53777A;

int eRadius = 10;

int bpm = 101;

float r;
float theta;
float a = 3;
float b = 5;
float aDif = 0.1;

boolean playing;

void setup() {
  
  //size( 800, 800);
  size( 23811, 23811);
  
  minim = new Minim(this);
  //buffer size 1024
  song = minim.loadFile("Soda Stereo - Persiana Americana.mp3");
  song.play();
  song.loop(1);
  playing = true;
  fft = new FFT( song.bufferSize(), song.sampleRate() );
  
  beat = new BeatDetect( song.bufferSize(), song.sampleRate() );
  beat.setSensitivity(300);
  beat.detectMode(BeatDetect.FREQ_ENERGY);
  
  colorMode(HSB);
  
  r= 0;
  theta= 0;
  
  background(5);
}

void draw(){
  if(playing){
    if(song.loopCount() == 0 ){
      song.pause();
      saveFrame("###.png");
      playing = false;
    }
  
    float avg = 0;
    eRadius = width/80;
    
    fft.forward(song.mix);
    beat.detect(song.mix);
    
    stroke(255, 0, 0, 128);  
    
    for(int i = 0; i < fft.specSize(); i++){
      avg += fft.getBand(i);
    }
    
    color c = lerpColor(color_1, color_3, avg/2500);
    
    if(beat.isKick()) eRadius = width/40;
    if(beat.isSnare()) eRadius = 3*width/160;
    
    noStroke();
    fill(c);
    drawInEspiral();
  }
}
void drawInEspiral(){
  translate(width/2 , height/2);
 
  theta += aDif;
  
  r = a+ b*theta;
  
  aDif = 1/r;
  
  float x = r*cos(theta);
  float y = r*sin(theta);
  
  ellipse(x, y, eRadius, eRadius);
}

void keyPressed(){
  if(!mute){
    song.mute();
    mute = true;
  }else {
    song.unmute();
    mute = false;
  }
  if(key=='s'){
    saveFrame("###.png");
  }
}

PImage src;
PImage backup;

int N = 300;
String folderName = "palnorte";
String fileDestination;

void setup(){
  
  size(1280,960);
  src = loadImage("palnorte.jpeg");
  //src.resize(720,720);
  //noLoop();
  backup = src.copy();
  image(src,0,0);
  
  fileDestination = folderName+"//#####.png";
}


void draw(){  
  //src.loadPixels();
  //src.filter(POSTERIZE, 5);
    //src.filter(DILATE);
      
  //image(src,0,0);
  
  loadPixels();
  SHIFTY();
  updatePixels();
  
  //saveFrame(fileDestination);
}

void mouseClicked(){
  if(mouseButton == LEFT){
    //src.filter(POSTERIZE, (int)(2 + 253.0*mouseX/width) );
    
    //src.filter(ERODE);
    saveFrame(fileDestination);
  }
  if(mouseButton == RIGHT){
    src = backup.copy();
  }
}

void SHIFTY(){
  
  for(int i=0; i< N; i++){
    int x = (int)random(width);
    int y = (int)random(height);
    int l = (int)random(30);
    color c = pixels[y*width +x];
    if(random(1)>0.5) {
      for(int j = 0; j<l; j++){
        //pixels[y*width + (x+j)%width] = c;
        pixels[((y+j)%height)*width + x] = c;
      }
    } else {
      for(int j = 0; j<l; j++){
        pixels[y*width + (x+j)%width] = c;
        //pixels[((y-j)%height+height)%height*width + x] = c;
      }
    }
    
  }

}
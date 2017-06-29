import java.util.Arrays;
import java.util.Comparator;

PImage img;

static final Comparator<Integer> pC = new Comparator<Integer>() {
  @ Override final int compare(final Integer c1, final Integer c2) {
    int h1 = ((int)c1>>16)&0xFF;
    int h2 = ((int)c2>>16)&0xFF;
    return h2 - h1;
  }
};

void setup(){

  //size(1280,960);
  fullScreen();
  img = loadImage("test1.jpeg");
  resizeImage();
  image(img, 0, 0);
  pixelSorting();
  image(img, img.width, 0);
  //colorMode(HSB);
}

void resizeImage() {
  float ratiow = 1.0*width/img.width;
  float ratioh = 1.0*height/img.height;
  float ratio = min(ratiow, ratioh);
  img.resize( (int)(ratio*img.width), (int)(ratio*img.height) );
}

void pixelSorting(){
  img.loadPixels();
  int[] pxs = img.pixels;
  for(int r=0; r<img.height-1; r++){
    // r*img.width, (r+1)*img.width,
    //Arrays.sort(pxs, pC );
    Arrays.sort(pxs, r*img.width, (r+1)*img.width );
  }
  img.updatePixels();
}

void draw() {



}

int[][] kernelx = { 
{-1, 0, 1},
{-2, 0, 2},
{-1, 0, 1}
};

int[][] kernely = { 
{-1,-2,-1},
{ 2, 0, 0},
{ 1, 2, 1}
};

PImage img;

void setup(){

  img = loadImage("valve_original.PNG");
  size(700,700);
  noLoop();
  
}


void draw(){
  float w2 = width/2;
  float h2 = height/2;
  
  img.loadPixels();
  image( img, 0, 0, w2, h2);
  
  PImage img3 = sobelOperator(img);
  image(img3,0,h2,w2,h2);
  
  PImage img2 = img;
  //img2.filter(THRESHOLD,0.4);
  img2.filter(DILATE);
  img2.filter(BLUR,1.5);
  image(img2, w2,0, w2, h2);
  
  PImage img4 = sobelOperator(img2);
  image(img4,w2,h2,w2,h2);
  image(img4,w2,h2,w2,h2);
}

float gaussian2d(int x,int y, float stdDev){
  float var2 = 2*stdDev*stdDev;
  float pow = -1 * ( x*x + y*y)/ (var2);
  return exp(pow)/(PI*var2);
}

float[][] createKernelGauss(float stdDev){
  float[][] ret = new float[3][3];
  float sum = 0;
  int iX = 0, iY = 0;
  for(int a = -1; a<=1; a++, iY++){
    iX = 0;
    for(int b = -1; b<=1; b++, iX++){
       sum += ret[iX][iY] = gaussian2d(a,b,stdDev);
    }
  }
  
  //normalize
  for(int i=0; i<3; i++){
    for(int j=0; j<3; j++)
      ret[i][j] /= sum;
  }
  
  return ret;
}

PImage gaussianBlur(PImage src, float stdDev){
  PImage out = createImage(src.width, src.height, RGB);
  float[][] kernel_gauss = createKernelGauss(stdDev);
  
  for (int y = 1; y < src.height-1; y++) { // Skip top and bottom edges
    for (int x = 1; x < src.width-1; x++) { // Skip left and right edges
      float magR=0, magB=0, magG=0;
      
      for(int a = 0; a < 3; a++) {
        for(int b = 0; b < 3; b++) {            
          int xn = x + a - 1;
          int yn = y + b - 1;
    
          int index = xn + yn * src.width;
          magR += 1.0*red(src.pixels[index]) * kernel_gauss[a][b];
          magB += 1.0*blue(src.pixels[index]) * kernel_gauss[a][b];
          magG += 1.0*green(src.pixels[index]) * kernel_gauss[a][b];
        }
      }
      
      out.pixels[y*src.width + x] = color(magR, magG, magB);
    }
  }
  
  return out;
}

PImage sobelOperator(PImage img){
   PImage edgeImg = createImage(img.width, img.height,RGB);
   img.filter(GRAY);
   for (int y = 1; y < img.height-1; y++) { // Skip top and bottom edges
    for (int x = 1; x < img.width-1; x++) { // Skip left and right edges
      int mX = magX(x, y);
      int mY = magY(x, y);
      
      float magTotal = sqrt(mX*mX + mY*mY);
      edgeImg.pixels[y*img.width + x] = color(magTotal);
    }
  }
  
  return edgeImg;
}

int magX(int x, int y){
  int mag = 0;
  
  for(int a = 0; a < 3; a++)
  {
      for(int b = 0; b < 3; b++)
      {            
          int xn = x + a - 1;
          int yn = y + b - 1;
  
          int index = xn + yn * img.width;
          mag += red(img.pixels[index]) * kernelx[a][b];
      }
  }
  return mag;
}

int magY(int x, int y){
  int mag = 0;
  
  for(int a = 0; a < 3; a++)
  {
      for(int b = 0; b < 3; b++)
      {            
          int xn = x + a - 1;
          int yn = y + b - 1;
  
          int index = xn + yn * img.width;
          mag += red(img.pixels[index]) * kernelx[a][b];
      }
  }
  return mag;
}
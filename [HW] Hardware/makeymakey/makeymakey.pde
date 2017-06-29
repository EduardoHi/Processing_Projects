PFont myFont;
float x,y;
color back;
color cBanana = #edee0e;
color cOrange = #eea40e;
color cText = #000000;
color green = color(20,255,20);
color red = color(255,20,20);
boolean fruit = false;
long timer = 0;
int input = 0;
long score = 0;

void setup(){
  
  fullScreen();
  ellipseMode(CENTER);
  x = width/2;
  y = height/2;
  
  back = #000000;
  
  myFont = createFont("Lato-Bold.ttf",100);
  textFont(myFont);
  textAlign(CENTER,CENTER);
}


void draw(){
  //background(back);
  if(fruit){
    background(cOrange);
      if(input==1){
        ++score;
        cText = green;
      } else if(input == 2){
        score -= 2;
        cText = red;
      }
  } else {
    background(cBanana);
      if(input==2) {
        ++score;
        cText = green;
      }else if(input == 1){
        score -= 2;
        cText = red;
      }
  }

  fill(150,170);
  text("SCORE: "+score,x-4,y+4);
  fill(cText);
  text("SCORE: "+score,x,y);
  
  if(random(1)<0.1 && timer >50){
    fruit = !fruit;
    timer = 0;
  }
  
  score = (long)max(score,0);
  ++timer;
  input = 0;
}

void keyReleased(){
  //if(keyCode==DOWN)
  if(keyCode==LEFT)
    input = 1;
  if(keyCode==RIGHT)
    input = 2;
  //if(keyCode==UP)
}
float slider, theta = 0, frms = 120, counter = 100;

void setup() {
    size(540,540);
}

void draw() {
    background(34);
    translate(width/2, height/2);
    
    float k = (10.0*mouseY/height) * (mouseX*1.0/width);
    beginShape();
    noFill();
    stroke(255);
    strokeWeight(1);
    for (float a=0; a<TWO_PI*k; a += 0.02) {
        float r = map(sin(theta+a*4),-1,1,100,200) * cos(k*a);
        float x = r * cos(a);
        float y = r * sin(a);
        vertex(x,y); 
    }
    endShape();
    theta += TWO_PI/frms;
    
    /*
    if (frameCount<=frms) {
        save("image-" + counter + ".png");
        counter++;
    }
    */
}
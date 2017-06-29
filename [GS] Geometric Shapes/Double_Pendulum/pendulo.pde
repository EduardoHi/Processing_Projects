class Pendulo {
  PVector pivot, pos1, pos2, prev1, prev2;
  int N = 4;
  float G = 9.81;
  float L1 = 100;
  float L2 = 100;
  float M1 = 100;
  float M2 = 100;
  
  int j = 0;
  int i = 0;
  int NSTEP = 6000;
  float h, TMIN, TMAX, TH10, W10, TH20, W20;
  float[] yin = new float[N];
  float[] yout = new float[N];
  
  float [] t = new float[NSTEP];
  float [] th1 = new float[NSTEP];
  float [] w1 = new float[NSTEP];
  float [] th2 = new float[NSTEP];
  float [] w2 = new float[NSTEP];
  
  //making it flow
  float T;
  float tH1, ntH1, tH2, ntH2;
  float W1, nW1, W2, nW2;
  
  Pendulo(){
    pivot = new PVector(0,0);
    pos1 = new PVector();
    pos2 = new PVector();
    prev1 = new PVector();
    prev2 = new PVector();
  
    //valores iniciales
    TMIN = 0;
    TMAX = 500;
    TH10 = random(360);
    W10 = random(360);
    TH20 = random(360);
    W20 = random(360);
    
    //making it flow
    //iniciar todo en 0
    T = TMIN;
    tH1=ntH1=tH2=ntH2=W1=nW1=W2=nW2 = 0;
    
    /* stepsize for integration */
  
    h = (TMAX - TMIN)/(NSTEP - 1.0);
    
    /* Define array of t values */
  
    for (i = 0; i < NSTEP; i++){
      t[i] = TMIN + h*i;
    }
    
    /* initial values - convert all angles to radians */
  
    th1[0] = TH10*PI/180.0;
    w1[0] = W10*PI/180.0;
    th2[0] = TH20*PI/180.0;
    w2[0] = W20*PI/180.0;
    //making it flow
    tH1 = TH10*PI/180.0;
    W1 = W10*PI/180.0;
    tH2= TH20*PI/180.0;
    W2 = W20*PI/180.0;
    
    /* perform the integration */
    for (i = 0; i < NSTEP - 1; i++){ 
      yin[0] = th1[i];
      yin[1] = w1[i];
      yin[2] = th2[i];
      yin[3] = w2[i];
      runge_kutta(t[i], yin, yout, h);
      th1[i+1] = yout[0];
      w1[i+1] = yout[1];
      th2[i+1] = yout[2];
      w2[i+1] = yout[3];
      }
  }
  
  void update(){
    prev1 = pos1.copy();
    prev2 = pos2.copy();
    pos1.x = L1*sin(tH1);
    pos1.y = L1*cos(tH1);
    pos2.x = pos1.x + L2*sin(tH2);
    pos2.y = pos1.y + L2*cos(tH2);

    //making it flow
    integration();
    shiftPlace();
  }
  
  //making it flow
  void integration(){
      yin[0] = tH1;
      yin[1] = W1;
      yin[2] = tH2;
      yin[3] = W2;
      runge_kutta( T , yin, yout, h);
      ntH1 = yout[0];
      nW1 = yout[1];
      ntH2 = yout[2];
      nW2 = yout[3];
      T+=h ;
  }
  //making it flow
  void shiftPlace(){
    tH1 = ntH1;
    W1 = nW1;
    tH2 = ntH1;
    W2 = nW2;
  }
    
  void derivs(float xin, float yin[], float dydx[]){

    /* function to fill array of derivatives dydx at xin */
  
    float den1, den2, del;
  
    dydx[0] = yin[1]; 
    
    del = yin[2]-yin[0];
    den1 = (M1+M2)*L1 - M2*L1*cos(del)*cos(del);
    dydx[1] = (M2*L1*yin[1]*yin[1]*sin(del)*cos(del) + M2*G*sin(yin[2])*cos(del) + M2*L2*yin[3]*yin[3]*sin(del) - (M1+M2)*G*sin(yin[0]))/den1;
    dydx[2] = yin[3];
  
    den2 = (L2/L1)*den1;
    dydx[3] = (-M2*L2*yin[3]*yin[3]*sin(del)*cos(del) + (M1+M2)*G*sin(yin[0])*cos(del)  - (M1+M2)*L1*yin[1]*yin[1]*sin(del) - (M1+M2)*G*sin(yin[2]))/den2;
  
    return;

  }
  
  void runge_kutta(float xin, float yin[], float yout[], float h){
    /* fourth order Runge-Kutta - see e.g. Numerical Recipes */
   
    int i;
    float hh, xh;
    float [] dydx = new float[N];
    float [] dydxt = new float[N];
    float [] yt = new float[N];
    float [] k1 = new float[N];
    float [] k2 = new float[N];
    float [] k3 = new float[N];
    float [] k4 = new float[N];
    
    
    hh = 0.5*h;
    xh = xin + hh; 
    
    derivs(xin, yin, dydx); /* first step */
    for (i = 0; i < N; i++){
      k1[i] = h*dydx[i];
      yt[i] = yin[i] + 0.5*k1[i];
      }
  
    derivs(xh, yt, dydxt); /* second step */ 
    for (i = 0; i < N; i++){
      k2[i] = h*dydxt[i];
      yt[i] = yin[i] + 0.5*k2[i];
      }   
  
    derivs(xh, yt, dydxt); /* third step */
    for (i = 0; i < N; i++){
      k3[i] = h*dydxt[i];
      yt[i] = yin[i] + k3[i];
      }
  
    derivs(xin + h, yt, dydxt); /* fourth step */
    for (i = 0; i < N; i++){
      k4[i] = h*dydxt[i];
      yout[i] = yin[i] + k1[i]/6. + k2[i]/3. + k3[i]/3. + k4[i]/6.;
      }
   
    return;

  }

  void display(){
    
    if(debug){
      line(0, 0, pos1.x, pos1.y);
      ellipse(pos1.x, pos1.y, 15, 15);
      line(pos1.x, pos1.y, pos2.x, pos2.y);
      ellipse(pos2.x, pos2.y, 15, 15);
    }
    
    //line(prev1.x, prev1.y, pos1.x, pos1.y);
    line(prev2.x, prev2.y, pos2.x, pos2.y);
  }
  
}

/* 


CODIGO PREVIO (PENDULO EN BRAZO MECÁNICO)


class Pendulo {
  PVector pivot, pos1, pos2, prev1, prev2;
  float vel1, acc1, theta1, L1;
  float vel2, acc2, theta2, L2;
  
  Pendulo(){
    pivot = new PVector(0,0);
    theta1 = PI*random(2);
    theta2 = PI*random(2);
    L1 = L2 = 100;
    pos1 = new PVector();
    pos2 = new PVector();
    prev1 =  new PVector();
    prev2 =  new PVector();
    vel1 = vel2 = 0;
    acc1 = acc2 = 0;
  }
  
  
  void update(){
    prev1 = pos1.copy();
    prev2 = pos2.copy();
    pos1.x = L1*sin(theta1);
    pos1.y = L1*cos(theta1);
    pos2.x = pos1.x + L2*sin(theta2);
    pos2.y = pos1.y + L2*cos(theta2);
    acc1 = - 0.4 / L1 * sin(theta1);
    acc2 = - 0.4 / L2 * sin(theta2);
    vel1 += acc1;
    vel2 += acc2;// + vel1;
    theta1 += vel1;
    theta2 += vel2;
  }
  
  void display(){
    
    if(debug){
      line(0, 0, pos1.x, pos1.y);
      ellipse(pos1.x, pos1.y, 15, 15);
      line(pos1.x, pos1.y, pos2.x, pos2.y);
      ellipse(pos2.x, pos2.y, 15, 15);
    }
    
    //line(prev1.x, prev1.y, pos1.x, pos1.y);
    line(prev2.x, prev2.y, pos2.x, pos2.y);
  }
  
}
*/
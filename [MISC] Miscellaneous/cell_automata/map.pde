class Map{
  int w, h, size;
  boolean[][] grid, n_grid;
  color c1, c2;
 
  Map(){
    this(width, height);
  }
  Map(int w, int h){
    this.w = w;
    this.h = h;
    size = width/w;
    grid = new boolean[w][h];
    n_grid = new boolean[w][h];
    randomize();
  }
  
  void turnOn(int x, int y){
    x = x>width ? width : x;
    y = y>height ? height : y;
    grid[x/size][y/size] = true;
  }
  color randomC(){
    return color(random(255), random(255), random(255));
  }
  
  void clear(){
    for(int y=0; y<h; y++){
        for(int x=0; x<w; x++){
          grid[x][y] = false;
        }
    }
  }

  void randomize(){
    for(int y=1; y<h-1; y++){
        for(int x=1; x<w-1; x++){
          grid[x][y] = random(1)>0.5 ? true : false ;
        }
    }
    c1 = randomC();
    c2 = randomC();
  }
  
  int neighbours(int x, int y){
    int n = 0;
    for(int i=-1; i<=1; i++)
      for(int j=-1; j<=1; j++)
         if(grid[x+i][y+j]) n++;;
    return n;
  }
  
  void update(){
    //Calculate next step
    for(int y=1; y<h-1; y++){
        for(int x=1; x<w-1; x++){
          int n = neighbours(x,y);
          if( n == 3 ) n_grid[x][y] = true;
          else if ( n == 4 ) n_grid[x][y] = true & grid[x][y];
          else n_grid[x][y] = false;
        }
    }
    //copy grid and erase new grid
    for(int y=1; y<h-1; y++){
      for(int x=1; x<w-1; x++){
        grid[x][y] = n_grid[x][y];
        n_grid[x][y] = false;
      }
    }
  }

  void display(){
    for(int y=0; y<h; y++){
      for(int x=0; x<w; x++){
        fill( grid[x][y] ? c1 : c2 );
        rect(x*size, y*size, size, size); 
      }
    }
  }
}
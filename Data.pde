class Data extends Drawable
{
  Plane grid;
  Point origin;
  Point monitor;
  Plot wave;
  int d_height;
  int d_width;
  int top_y;
  int left_x;
  String mode;
  int numWaves;
  float period;
  boolean circles;
  Data()
  {
    d_height = height/2;
    d_width = width;
    top_y = 0;
    left_x = 0;
    mode = "sine";
    numWaves = 1;
    grid = new Plane(d_height/2, d_height/2, d_height-50, d_height-50, 2, 2);
    origin = new Point(0,0);
    monitor = new Point(2,0);
    grid.attach(monitor);
    grid.attach(origin);
    wave = new Plot(d_height+25, d_height/2, d_width-(d_height+50), d_height-50, 5, 2);
    wave.setTrack(((Point)origin.last()));
    children = new ArrayList<Drawable>(0);
    period = 5.0;
    circles = false;
  }
  
  void setupWave(){
    if(!(origin.chain instanceof NullVector)){
      origin.unchain();
    }
    if(mode.toLowerCase().equals("sine")){
      origin.chain(new Vector(origin, 0, 1, period));
      if(circles){
        ((Point)origin.last().parent.parent).attach(new Circle(((Point)origin.last().parent.parent), 1.0));
      }
    } else if(mode.toLowerCase().equals("square")){
      for (int i = 0; i < numWaves; i++){
        origin.chain(new Vector(origin, 0, (4/PI)/(2*i+1), period/(2*i+1)));
        if(circles){
          ((Point)origin.last().parent.parent).attach(new Circle(((Point)origin.last().parent.parent), (4/PI)/(2*i+1)));
        }
      }
    } else if(mode.toLowerCase().equals("sawtooth")){
      for (int i = 1; i <= numWaves; i++){
        origin.chain(new Vector(origin, 0, (2/PI)*pow(-1,i)/i, period/i));
        if(circles){
          ((Point)origin.last().parent.parent).attach(new Circle(((Point)origin.last().parent.parent), (2/PI)/i));
        }
      }
    } else if(mode.toLowerCase().equals("triangle")){
      for (int i = 0; i < numWaves; i++){
        origin.chain(new Vector(origin, 0, pow(-1,i)*(8/pow(PI,2))/pow((2*i+1),2), period/(2*i+1)));
        if(circles){
          ((Point)origin.last().parent.parent).attach(new Circle(((Point)origin.last().parent.parent), (8/pow(PI,2))/pow((2*i+1),2)));
        }
      }
    } else {
      println("I don't know how to do that.");
    }
    wave.setTrack(origin.last());
  }
  
  void addWave(){
    numWaves += 1;
    setupWave();
  }
  
  void setNumWaves(int n){
    numWaves = n;
    setupWave();
  }
  
  void setMode(String _mode){
    mode = _mode;
    setupWave();
  }
  
  void removeWave(){
    numWaves -= 1;
    ((Point)origin.last().parent.parent).unchain();
  }
  
  void draw()
  {
    monitor.move(2, origin.last().y);
    grid.draw();
    wave.draw();
    
    for(Drawable child : children){
      child.draw();
    }
  }
}
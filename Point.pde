class Point extends Drawable
{
  float x;
  float y;
  color c;
  int size;
  Vector chain;
  Plot trackedBy;
  Point()
  {
    
  }
  Point(float _x, float _y)
  {
    x=_x;
    y=_y;
    c=color(255,255,255);
    size = 10;
    children = new ArrayList<Drawable>(0);
    chain = new NullVector();
    trackedBy = new NullPlot();
  }
  
  void setColor(color _c)
  {
    c=_c;
  }
  
  void setSize(int _s)
  {
    size=_s;
  }
  
  void chain(Vector v)
  {
    Point last = this;
    while(!(last.chain instanceof NullVector)){
      last = last.chain.end;
    }
    println(this == last);
    last.attach(v);
    if(last.chain instanceof NullVector){
      last.chain = v;
    } else {
      println("Warning: Overwriting chain vector.");
      last.chain = v;
    }
  }
  
  void unchain()
  {
    println("Entered unchain");
    if(!(((Point)last()).trackedBy instanceof NullPlot)){
      ((Point)last()).trackedBy.setTrack(this);
    }
    detach(chain);
    chain = new NullVector();
  }
  
  Point last()
  {
    if(chain instanceof NullVector)
    {
      return this;
    }
    return chain.end.last();
  }
  
  void move(float _x, float _y)
  {
    x=_x;
    y=_y;
  }
  
  void draw()
  {
    pushStyle();
    fill(c);
    stroke(c);
    ellipseMode(CENTER);
    if(parent instanceof Plane){
      ellipse(((Plane)parent).origin_x + (x/((Plane)parent).x_max) * ((Plane)parent).width/2, ((Plane)parent).origin_y - (y/((Plane)parent).y_max) * ((Plane)parent).height/2, size, size);
    }
    for (Drawable child : children){
      child.draw();
    }
    popStyle();
  }
}
class NullPoint extends Point
{
  
}
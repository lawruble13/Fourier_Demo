class Vector extends Drawable
{
  Point start;
  Point end;
  float angle;
  float len;
  color c;
  float period;
  Vector(){
    
  }
  Vector(Point _start, Point _end, float _period)
  {
    start = _start;
    end = _end;
    float dx = end.x - start.x;
    float dy = end.y - start.y;
    if(dx > 0){
      angle = atan(dy/dx);
    } else if(dx < 0){
      angle = PI + atan(dy/dx);
    }
    len=sqrt(pow(dx, 2)+pow(dy, 2));
    c=color(255,255,255);
    period = _period;
    children = new ArrayList<Drawable>(0);
  }
  
  Vector(Point _start, float _angle, float _len, float _period)
  {
    start = _start;
    angle = _angle;
    len = _len;
    float dx, dy;
    dx = len*cos(angle);
    dy = len*sin(angle);
    end = new Point(start.x+dx, start.y+dy);
    c=color(255,255,255);
    period = _period;
    children = new ArrayList<Drawable>(0);
  }
  
  void setColor(color _c){
    c=_c;
  }
  
  void attached(Drawable _parent)
  {
    parent = _parent;
    this.attach(end);
  }
  
  void rotate(float _angle)
  {
    angle += _angle;
    angle %= TWO_PI;
    float dx = len*cos(angle);
    float dy = len*sin(angle);
    end.move(start.x+dx, start.y+dy);    
  }
  
  void move(float dx, float dy)
  {
    start.move(start.x+dx, start.y+dy);
    end.move(end.x+dx, end.y+dy);
  }
  
  void move(Point p)
  {
    float dx = p.x-start.x;
    float dy = p.y-start.y;
    move(dx, dy);
  }
  
  void draw()
  {
    pushStyle();
    stroke(c);
    if(parent instanceof Vector){
      start = ((Vector)parent).end;
    } else if(parent instanceof Point) {
      start = (Point)parent;
    }
    Drawable grid = parent;
    while(!(grid instanceof Plane)){
      grid=grid.parent;
    }
    if(abs(period) > 0){
      rotate(TWO_PI/(FPS*period));
    } else {
      rotate(0);
    }
    float dy = end.y - start.y;
    float dx = end.x - start.x;
    float h = -((Plane)grid).height*(dy/((Plane)grid).y_max)/2;
    float w = ((Plane)grid).width*(dx/((Plane)grid).x_max)/2;
    float angle = 0;
    if(dx > 0){
      angle = atan(h/w);
    } else {
      angle = PI + atan(h/w);
    }
    float len = sqrt(pow(h,2) + pow(w,2));
    drawArrow(int(((Plane)grid).origin_x+(start.x/((Plane)grid).x_max)*((Plane)grid).width/2), int(((Plane)grid).origin_y-(start.y/((Plane)grid).y_max)*((Plane)grid).height/2), int(len), angle);
    for(Drawable child : children){
      child.draw();
    }
    popStyle();
  }
}

class NullVector extends Vector
{
  
}
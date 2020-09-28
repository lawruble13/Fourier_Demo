class Circle extends Drawable
{
  Point center;
  float radius;
  color c;
  
  Circle(Point _center, float _radius)
  {
    center = _center;
    radius = _radius;
    children = new ArrayList<Drawable>(0);
    c=color(255,255,255);
  }
  
  void setColor(color _c)
  {
    c=_c;
  }
  void draw()
  {
    pushStyle();
    noFill();
    strokeWeight(2);
    stroke(c);
    ellipseMode(RADIUS);
    if(parent instanceof Vector){
      center = ((Vector)parent).end;
    } else if(parent instanceof Point) {
      center = (Point)parent;
    }
    Drawable grid = parent;
    while(!(grid instanceof Plane)){
      grid=grid.parent;
    }
    ellipse(((Plane)grid).origin_x+(center.x/((Plane)grid).x_max)*((Plane)grid).width/2, ((Plane)grid).origin_y-(center.y/((Plane)grid).y_max)*((Plane)grid).height/2, (radius/((Plane)grid).x_max)*((Plane)grid).width/2, (radius/((Plane)grid).y_max)*((Plane)grid).width/2);
    for(Drawable child : children){
      child.draw();
    }
    popStyle();
  }
}
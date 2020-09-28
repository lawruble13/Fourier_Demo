class Plane extends Drawable
{
  int origin_x;
  int origin_y;
  int width;
  int height;
  float x_max;
  float y_max;
  color c;
  Plane(int _origin_x, int _origin_y, int _width, int _height, float _x_max, float _y_max)
  {
    origin_x = _origin_x;
    origin_y = _origin_y;
    width = _width;
    height = _height;
    x_max = _x_max;
    y_max = _y_max;
    c = color(255,255,255);
    children = new ArrayList<Drawable>(0);
  }
  
  void setColor(color _c)
  {
    c=_c;
  }
  
  void draw()
  {
    pushStyle();
    stroke(c);
    strokeWeight(2);
    //draw outline
    line(origin_x-width/2, origin_y-height/2, origin_x+width/2, origin_y-height/2);
    line(origin_x-width/2, origin_y+height/2, origin_x+width/2, origin_y+height/2);
    line(origin_x-width/2, origin_y-height/2, origin_x-width/2, origin_y+height/2);
    line(origin_x+width/2, origin_y-height/2, origin_x+width/2, origin_y+height/2);
    strokeWeight(1);
    for(int i = 1; i < x_max; i++){
      //draw vertical, positive gridlines
      line(origin_x+i*(width/(2*x_max)), origin_y-height/2, origin_x+i*(width/(2*x_max)), origin_y+height/2);
      //draw vertical, negative gridlines
      line(origin_x-i*(width/(2*x_max)), origin_y-height/2, origin_x-i*(width/(2*x_max)), origin_y+height/2);
    }
    for(int i = 1; i < y_max; i++){  
      //draw horizontal, positive gridlines
      line(origin_x-width/2, origin_y-i*(height/(2*y_max)), origin_x+width/2, origin_y-i*(height/(2*y_max)));
      //draw horizontal, negative gridlines
      line(origin_x-width/2, origin_y+i*(height/(2*y_max)), origin_x+width/2, origin_y+i*(height/(2*y_max)));
    }
    //draw axes
    strokeWeight(3);
    line(origin_x-width/2, origin_y, origin_x+width/2, origin_y);
    line(origin_x, origin_y-height/2, origin_x, origin_y+height/2);
    for(Drawable child : children){
      child.draw();
    }
    popStyle();
  }
}
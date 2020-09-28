class Plot extends Drawable
{
  int origin_x;
  int origin_y;
  int width;
  int height;
  float x_max;
  float y_max;
  color c;
  Point tracking;
  FloatList data;
  int max_datapoints;
  
  Plot()
  {
    
  }
  
  Plot(int _origin_x, int _origin_y, int _width, int _height, float _x_max, float _y_max)
  {
    origin_x = _origin_x;
    origin_y = _origin_y;
    width = _width;
    height = _height;
    x_max = _x_max;
    y_max = _y_max;
    c=color(255, 255, 255);
    tracking = new NullPoint();
    max_datapoints = 1200;
    data = new FloatList(0);
    for (int i = 0; i < max_datapoints; i++){
      data.append(0);
    }
  }
  
  void setColor(color _c)
  {
    c=_c;
  }
  
  void setTrack(Point p)
  {
    tracking = p;
    p.trackedBy = this;
  }
  
  void draw()
  {
    pushStyle();
    textSize(200);
    textFont(font);
    stroke(c);
    
    
    strokeWeight(3);
    //draw axes
    line(origin_x, origin_y-height/2, origin_x, origin_y+height/2);
    line(origin_x, origin_y, origin_x + width, origin_y);
    
    strokeWeight(2);
    //draw y coordinates
    int i = ceil(-y_max);
    while (i <= floor(y_max)){
      float dy = height/(2*y_max);
      text(str(i), origin_x-40, origin_y-i*dy);
      i++;
    }
    
    //draw x coordinates
    
    float numSecs = max_datapoints/FPS/2;
    int secsPerTick = floor(numSecs/6);
    float dx = secsPerTick*width/numSecs;
    float numTicks = numSecs/secsPerTick;
    
    i = 0;
    while (i < numTicks){
      text(str(i*secsPerTick), origin_x + dx*i, origin_y+height/2+40);
      i++;
    }
    
    
    data.append(tracking.y);
    if(data.size() > max_datapoints){
      data.remove(0);
      for(int j = 1; j < data.size(); j++){
        data.set(j-1, data.get(j));
      }

    }
    
    for(int j = data.size()-1; j>=0; j--){
      float y = height*(data.get(j)/y_max)/2;
      float x = width*(1-float(j)/data.size());
      ellipse(origin_x + x, origin_y - y, 5, 5);
    }
    
    popStyle();
  }
}

class NullPlot extends Plot
{
  
}
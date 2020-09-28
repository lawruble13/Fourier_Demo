class Button extends Drawable
{
  int function;
  String text;
  int x_pos;
  int y_pos;
  int width;
  int height;
  String mode;
  int num;
  Data data;
  color c;
  
  Button(int _function, String _text, int _x_pos, int _y_pos, Data _data)
  {
    function = _function;
    text = _text;
    x_pos = _x_pos;
    y_pos = _y_pos;
    data = _data;
    if(function == WAVETYPE){
      mode = text.toLowerCase();
    } else if(function == SETNUM){
      num = Integer.parseInt(text);
    }
    width = 200;
    height = 50;
    c = color(255, 255, 255);
  }
  
  Button setMode(String _mode)
  {
    mode = _mode;
    return this;
  }
  
  Button setNum(int _num)
  {
    num = _num;
    return this;
  }
  
  Button setSize(int _width, int _height)
  {
    width = _width;
    height = _height;
    return this;
  }
  
  Button setColor(color _c)
  {
    c=_c;
    return this;
  }
  
  void click(){
    switch(function){
      case WAVETYPE:
        data.setMode(mode);
        break;
      case ADDWAVE:
        data.addWave();
        break;
      case REMOVEWAVE:
        data.removeWave();
        break;
      case SETNUM:
        data.setNumWaves(num);
        break;
      case PAUSE:
      case RESUME:
      case RESET:
        break;
      case CIRCLES:
        data.circles = !data.circles;
        data.setupWave();
        break;
      case FRAMERATE:
        int t = num-10;
        if(t < 10){
          t=60;
        }
        frameRate(t);
        FPS = t;
        text = str(t);
        num=t;
        break;
    }
  }
  
  void draw()
  {
    pushStyle();
    noFill();
    strokeWeight(2);
    stroke(c);
    rectMode(CORNER);
    rect(x_pos, y_pos, width, height);
    textFont(font);
    textSize(30);
    fill(c);
    text(text,x_pos+10, y_pos+40);
    popStyle();
  }
}

class InputBox extends Drawable
{
  String input;
  Data data;
  boolean listening;
  int target;
  int last;
  boolean cursor;
  int x_pos;
  int y_pos;
  int width;
  int height;
  
  InputBox(int _target, int _x_pos, int _y_pos, Data _data)
  {
    input = "";
    data = _data;
    listening = false;
    target = _target;
    x_pos = _x_pos;
    y_pos = _y_pos;
    width=500;
    height=50;
  }
  
  void setSize(int _width, int _height)
  {
    width=_width;
    height=_height;
  }
  void click(){
    listening = true;
  }
  
  void input(char c)
  {
    input = input.concat(str(c));
  }
  
  void enter()
  {
    listening = false;
    if(target == NUMWAVES){
      data.numWaves = Integer.parseInt(input);
    } else if(target == PERIOD){
      data.period = Float.parseFloat(input);
    }
    data.setupWave();
    input = "";
  }
  
  void backspace()
  {
    if(input.length() > 0){
      input = input.substring(0, input.length()-1);
    }
  }
  
  void draw()
  {
    pushStyle();
    noFill();
    strokeWeight(2);
    stroke(color(255, 255, 255));
    rectMode(CORNER);
    rect(x_pos, y_pos, width, height);
    textFont(font);
    textSize(30);
    fill(color(255, 255, 255));
    String add;
    if(cursor && listening){
      add = "|";
    } else {
      add = "";
    }
    if(millis()-last > 500){
      cursor = !cursor;
      last = millis();
    }
    text(input.concat(add),x_pos+10, y_pos+40);
    popStyle();
  }
}

class TextBox extends Drawable
{
  String text;
  int x_pos;
  int y_pos;
  int width;
  int height;
  color c;
  
  TextBox(String _text, int _x_pos, int _y_pos)
  {
    text = _text;
    x_pos = _x_pos;
    y_pos = _y_pos;
    width = 300; 
    height = 50;
    c=color(202, 202, 255);
  }
  
  void setSize(int _width, int _height)
  {
    width = _width;
    height = _height;
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
    rectMode(CORNER);
    rect(x_pos, y_pos, width, height);
    textFont(font);
    textSize(30);
    fill(c);
    text(text,x_pos+10, y_pos+40);
    popStyle();
  }
}
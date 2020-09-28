int FPS = 60;

void drawArrow(int cx, int cy, int len, float angle){
  pushMatrix();
  translate(cx, cy);
  rotate(angle);
  line(0,0,len, 0);
  line(len, 0, len - 8, -8);
  line(len, 0, len - 8, 8);
  popMatrix();
}

void drawArrowDeg(int cx, int cy, int len, float angle)
{
  drawArrow(cx, cy, len, radians(angle));
}



class VectorException extends Exception
{
  String msg;
  VectorException(String _msg){
    msg = _msg;
  }
  VectorException(){
    msg = "There are no vectors in this Drawable tree.";
  }
}

final int WAVETYPE = 1;
final int ADDWAVE = 2;
final int REMOVEWAVE = 3;
final int SETNUM = 4;
final int PAUSE = 5;
final int RESUME = 6;
final int RESET = 7;
final int CIRCLES = 8;
final int FRAMERATE = 9;
final int PERIOD = 1;
final int NUMWAVES = 2;
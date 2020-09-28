abstract class Drawable
{
  Drawable parent;
  ArrayList<Drawable> children;
  
  void attach(Drawable child)
  {
    children.add(child);
    child.attached(this);
  }
  
  void attached(Drawable _parent)
  {
    parent = _parent;
  }
  
  void detach(Drawable _child)
  {
    println("Entered detach");
    _child.detached();
    boolean removed = false;
    for(int i = 0; i < children.size(); i++)
    {
      if(!removed && children.get(i) == _child){
        children.remove(i);
        removed = true;
      } else {
        children.set(i-1,children.get(i));
      }
    }
    println("Exiting detached");
  }
  
  void detached()
  {
    println("Entered detached");
    println(children.size());
    if(children.size() > 0){
      for (int i = 0; i < children.size(); i++){
        detach(children.get(i));
      }
    }
    children = null;
    parent = null;
    println("Exiting detached");
  }
  
  
  abstract void draw();
}
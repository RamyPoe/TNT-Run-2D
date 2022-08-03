class Hitbox {
  //Center of rect
  private Coord pos;
  
  //Full width and height
  public float w, h;
  private float left, right, top, bottom;
  
  //Constructor
  Hitbox(Coord pos, float w, float h) {
    this.pos = pos;
    this.w = w;
    this.h = h;
    
    calcSides();
  }
  
  //Check for collision between two Hitbox
  public boolean collide(Hitbox hbox) {
    if (left < hbox.right && right > hbox.left && top < hbox.bottom && bottom > hbox.top) {
      return true;
    }
    return false;
  }
  
  //Check for collision between hitbox and point
  public boolean collidePoint(float x, float y) {
    if (x > left && x < right && y > top && y < bottom) {
      return true;
    }
    return false;
  }
  
  //Set new position
  public void setPos(Coord newPos) {
    pos = newPos;
    
    calcSides();
  }
  
  //Set new size
  public void setSize(float w, float h) {
    this.w = w;
    this.h = h;
    
    calcSides();
  }
  
  //Calculate side positions using pos, w, h (MUST BE CALLED WHENEVER POS CHANGES)
  public void calcSides() {
    left = pos.x - w/2;
    right = pos.x + w/2;
    top = pos.y - h/2;
    bottom = pos.y + h/2;
  }
  
  public void visualize() {
    stroke(255, 10, 10);
    strokeWeight(3);
    fill(0, 0);
    rectMode(CENTER);
    
    rect(pos.x, pos.y, w, h);
  }
  
}

class KeyManager {
  //Up, Down, Left, Right, Jump
  public boolean[] keys;
  
  KeyManager() {
    //Initialize array for inputs
    keys = new boolean[5];
  }
  
  //====================
  //Getters
  //====================
  
  public boolean up()    { return keys[0]; }
  public boolean down()  { return keys[1]; }
  public boolean left()  { return keys[2]; }
  public boolean right() { return keys[3]; }
  public boolean jump()  { return keys[4]; }
  
  public boolean noMovement_x() {
    if (!keys[2] && !keys[3]) {
      return true;
    }
    return false;
  }
  
  public boolean noMovement_y() {
    if (!keys[0] && !keys[1]) {
      return true;
    }
    return false;
  }
  
  
  //====================
  //Pressing Keys
  //====================
  
  public void press_up() {
    keys[0] = true;
  }
  public void press_down() {
    keys[1] = true;
  }
  public void press_left() {
    keys[2] = true;
  }
  public void press_right() {
    keys[3] = true;
  }
  public void press_jump() {
    keys[4] = true;
  }
  
  
  //====================
  //Releasing Keys
  //====================
  
  public void release_up() {
    keys[0] = false;
  }
  public void release_down() {
    keys[1] = false;
  }
  public void release_left() {
    keys[2] = false;
  }
  public void release_right() {
    keys[3] = false;
  }
  public void release_jump() {
    keys[4] = false;
  }
}

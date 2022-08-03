class Tile {
  //Center of tile
  Coord pos;

  //Hitbox for collision detection
  public Hitbox hbox;

  //State is one of:
  //   1   (active)
  //   2   (still active) / breaking
  //   3   (inactive)
  private int state = 1;
  private int time_breaking;             //Hold the time that the tile was touched
  private final int TIME_TO_BREAK = 650; //How long it should take to break completely (ms)
  private final int ANIM_DELAY = 250;    //How long to wait before starting to shrink the tile, this is so it looks more like a trail (ms)
  private color active_color;

  //All tiles should ideally be the same dimensions
  private float w = 0;
  private float h = 0;

  //Constructor
  Tile(float x, float y, float w, float h) {
    pos = new Coord(x, y);
    this.w = w;
    this.h = h;

    hbox = new Hitbox(pos, w, h);
  }

  //Inside draw loop
  public void tick() {
    //Check if its time to swap states
    if (state == 2 && millis()-time_breaking >= TIME_TO_BREAK) {
      setStateBroken();
    }
    
    //Draw the tile
    display();
  }
  
  private void display() {
    if (state == 3) {
      return;
    }
    
    noStroke();
    fill(getColor());
    rectMode(CENTER);
      
    if (state == 1) {
      rect(pos.x, pos.y, w, h);
    } else if (state == 2) {
      float scale = (TIME_TO_BREAK-(millis()-time_breaking))/ (float) (TIME_TO_BREAK-ANIM_DELAY);
      if (scale > 1) { scale = 1; }

      rect(pos.x, pos.y, w*scale, h*scale);
      hbox.setSize(w*scale, h*scale);
    }
    
  }

  //Set the color of the tile
  public void setColor(color c) {
    active_color = c;
  }

  //Tile is breaking, will break after time period
  public void setStateBreaking() {
    state = 2;
    time_breaking = millis();
  }

  //Tile has been broken
  public void setStateBroken() {
    state = 3;
  }

  //Returns color based on state
  public color getColor() {
    switch(state) {
    case 1:
      return active_color;
    case 2:
      return active_color;
    case 3:
      return color(255, 255);
    default:
      return color(255, 255);
    }
  }
}

class Button {
  //Hold center position and dimensions
  Coord pos;
  private int w, h;
  
  //For collision/click checking
  private Hitbox hbox;
  
  //Settings for displaying
  public String text;
  
  private color backgroundColor = color(245);
  private color borderColor = color(20);
  private color textColor = color(20);
  private color hoverColor = color(220);
  private int borderThickness = 4;
  private int textSize = 32;
  
  //Constructor
  Button(int x, int y, int w, int h, String text) {
    pos = new Coord( (float) x, (float) y);
    this.w = w;
    this.h = h;
    this.text = text;
    
    hbox = new Hitbox(pos, (float) w, (float) h);
  }
  
  public void display() {
    //Draw Rectangle
    stroke(borderColor); strokeWeight(borderThickness);
    rectMode(CENTER);
    fill((hovering() ? hoverColor : backgroundColor));
    rect(pos.x, pos.y, w, h, 10);
    
    //Draw text on top
    fill(textColor);
    textAlign(CENTER);
    textSize(textSize);
    text(text, pos.x, pos.y + textAscent()*0.3);
  }
  
  //Check for click
  public boolean clicked() {
    if (mousePressed && !mouseDown && hbox.collidePoint(mouseX, mouseY)) {
      return true;
    }
    return false;
  }
  
  //Check for hover
  public boolean hovering() {
    return hbox.collidePoint(mouseX, mouseY);
  }
  
  //Setters for display options
  public Button setBackgroundColor (color c) { backgroundColor = c; return this; }
  public Button setBorderColor     (color c) { borderColor     = c; return this; }
  public Button setTextColor       (color c) { textColor       = c; return this; }
  public Button setHoverColor      (color c) { hoverColor      = c; return this; }
  public Button setBorderThickness (int   s) { borderThickness = s; return this; }
  public Button setTextSize        (int   s) { textSize        = s; return this; }
  
}

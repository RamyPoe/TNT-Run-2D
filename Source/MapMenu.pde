class MapMenu {
  Map[] maps;
  MapFrame[] mapFrames;
  public int selectedMap = 0;
  
  PImage downArrowImg = loadImage("assets/menu/arrow-down.png");
  
  MapMenu() {
    maps =  new Map[]{ new Map()
                             .setJumpLength(1000)
                             .setJumpSize(60)
                             .setAccel(0.7)
                             .setDecel(0.2)
                             .setMaxVel(6)
                             .setRestitution(0.96)
                             .setAirDrag(0.3)
                             .setActiveColor(color(60, 200, 60))
                             .setDeadColor(color(131, 101, 57)),
                             
                       new Map()
                             .setJumpLength(1200)
                             .setJumpSize(100)
                             .setAccel(1)
                             .setDecel(0.07)
                             .setMaxVel(7)
                             .setRestitution(0.95)
                             .setAirDrag(0.4)
                             .setActiveColor(color(90, 90, 255))
                             .setDeadColor(color(10, 10, 255)),
                             
                       new Map()
                             .setJumpLength(500)
                             .setJumpSize(55)
                             .setAccel(0.5)
                             .setDecel(0.1)
                             .setMaxVel(4.5)
                             .setRestitution(0.99)
                             .setAirDrag(0.1)
                             .setActiveColor(color(255, 204, 203))
                             .setDeadColor(color(139, 10, 0)),
                      };

    //Create frame to draw those settings as options
    mapFrames = new MapFrame[maps.length];
    
    //Create coordinates
    int cur_x = 40;
    int cur_y = 115;
    int x_padding = 80;
    for (int i = 0; i < mapFrames.length; i++) {
      mapFrames[i] = new MapFrame(cur_x, cur_y);
      cur_x += x_padding + mapFrames[i].w;
    }
    
    //Individual Settings
    mapFrames[0].setImage("assets/menu/grasslands.jpg") .setDescription("Grass Lands\n\n\tNormal Speed\n\tNormal Jump\n\tNormal Friction");
    mapFrames[1].setImage("assets/menu/tundra.jpg")     .setDescription("Tundra\n\n\tHigh Speed\n\tHigh Jump\n\tLow Friction");
    mapFrames[2].setImage("assets/menu/volcanic.jpg")   .setDescription("Volcanic Magma\n\n\tLow Speed\n\tLow Jump\n\tHigh Friction");

  }
  
  public void display() {
    //Background/clean slate
    background(255);
    
    //Draw each Frame
    for (int i = 0; i < mapFrames.length; i++) {
      mapFrames[i].display();
    }
  
    //Show which map is selected
    imageMode(CENTER);
    image(downArrowImg, mapFrames[selectedMap].x+mapFrames[selectedMap].w/2, mapFrames[selectedMap].y-55, 80, 70);
    
    //Change mouse on hover
    for (int i = 0; i < mapFrames.length; i++) {
      if (mapFrames[i].collideImage(mouseX, mouseY)) {
        if (!fadeOut) { cursor(HAND); } else { cursor(ARROW); }
        break;
      } else if (i == mapFrames.length-1) {
        cursor(ARROW);
      }
    }

  }
  
  //Used in the main method change the map
  public void setMap(int n) {
    selectedMap = n;
  }
  
  //Click detection for each map
  public int checkMapClicked() {
    for (int i = 0; i < mapFrames.length; i++) {
      if (mapFrames[i].collideImage(mouseX, mouseY)) {
        if (mousePressed && !mouseDown) {
          return i;
        }
      }
    }
    return -1;
  }
  
  //Used in main method to get selected map
  public Map getMap() {
    return maps[selectedMap];
  }
  
}


class MapFrame {
  public int x, y;
  public final int w = 320;
  public final int h = 530; //470
  
  PImage img;
  String description = "";
  Hitbox hbox;
  
  private final color borderColor = color(20);
  private final int borderThickness = 4;
  private final int fontSize = 24;
  private final color fontColor = color(255);
  private final color backgroundColor = color(100);
  
  MapFrame(int x, int y) {
    this.x = x;
    this.y = y;
    
    //For the image
    hbox = new Hitbox(new Coord(x+10+((w-20)/2), y+10+(h*0.58/2)), w-20, h*0.58);
  }
  
  public MapFrame setDescription(String text) { description = text; return this; }
  public MapFrame setImage(String url) { img = loadImage(url); return this; }
  
  public void display() {
    //Border
    rectMode(CORNER);
    stroke(borderColor);
    strokeWeight(borderThickness);
    fill(backgroundColor);
    rect(x, y, w, h, 20);
    
    //Cover Image
    if (img != null) {
      imageMode(CORNER);
      image(img, x+10, y+10, w-20, h*0.58);
    }
    
    //Text
    textSize(fontSize);
    fill(fontColor);
    rectMode(CORNER);
    textAlign(CENTER, TOP);
    text(description, x+w/2, y+h*0.63); 
    
  }
  
  public boolean collideImage(int x, int y) {
    return hbox.collidePoint(x, y);
  }
  
  
}

class Player{
  //Hold player position
  Coord pos;
  private boolean in_air = false;   //Whether or not the player is in the air
  private int time_jumping;         //Program time when jump is first called
  public int air_time = 1000;       //How long a jump should last (ms)
  public int jump_size = 60;        //Size of the player at the peak of the jump
  
  
  //For collision detection
  Hitbox hbox;
  
  //For moving player with keyboard, used in game class
  KeyManager keys = new KeyManager();
  
  //For calculating movement with momentum
  public float maxVel = 6;
  private float xVel;
  private float yVel;
  float accel = 0.7;
  float decel = 0.2;
  
  public float coeff_restitution = 0.96f;
  public float coeff_air_drag = 0.3f;
  
  //For drawing
  final int size = 25;
  final int hbox_size = size-10;
  color c = color(200, 200, 60);
  
  //Gets the starting time of the game, used for grace period
  public int gracePeriodStart;
  
  //For text (3, 2, 1)
  PFont font;
  
  //Constructor
  Player(float x, float y) {
    xVel = 0.0f;
    yVel = 0.0f;
    pos = new Coord(x, y);
    
    hbox = new Hitbox(pos, hbox_size, hbox_size);
    in_air = true;
    
    gracePeriodStart = millis();
    font = createFont("Arial", 100, true);
  }
  
  //See if player is in air/jumping
  public boolean inAir() {
    return in_air;
  }

  
  //Called in the draw loop
  public void tick() {
    updatePos();
    hbox.calcSides();
    display();
  }
  
  public void display() {
    ellipseMode(CENTER);
    stroke(100);
    strokeWeight(2);
    fill(c);
    
    if (in_air) {
      float size_ = getJumpSize( (millis() - time_jumping) / (float) air_time );
      ellipse(pos.x, pos.y, size_, size_);
    } else {
      ellipse(pos.x, pos.y, size, size);      
    }
    
    //Grace period, player is flying
    if (millis()-gracePeriodStart < 3400) {
      in_air = true;
      time_jumping = millis()-air_time/2;
    }

  }
  
  public void updatePos() {
    //Apply movements based on Key Presses
    if (keys.up())    { moveUp();    }
    if (keys.down())  { moveDown();  }
    if (keys.left())  { moveLeft();  }
    if (keys.right()) { moveRight(); }
    if (keys.jump())  { moveJump();  }
    
    //Deceleration
    if (keys.noMovement_x()){ decelerate_x(); }
    if (keys.noMovement_y()){ decelerate_y(); }
    
    //Apply velocity for next frame
    pos.x += xVel;
    pos.y += yVel;
    
    //Bounce off walls
    if (pos.x-size/2 < 0) {
      pos.x = abs(pos.x-size/2)+size/2;
      xVel *= -1*coeff_restitution;
    } else if (pos.x+size/2 > width) {
      pos.x = width-(pos.x+size/2-width)-size/2;
      xVel *= -1*coeff_restitution;
    }
    
    if (pos.y-size/2 < 0) {
      pos.y = abs(pos.y-size/2)+size/2;
      yVel *= -1*coeff_restitution;
    } else if (pos.y+size/2 > height) {
      pos.y = height-(pos.y+size/2-height)-size/2;
      yVel *= -1*coeff_restitution;
    }
    
    
    
    //Check jump status and grace period
    if (millis()-time_jumping >= air_time) {
      in_air = false;
    }
    
    //Printing countdown 3,2,1
    if (millis()-gracePeriodStart < 3400) {
      textFont(font);
      fill(255);
      textAlign(CENTER);
      text(4 - (int) ((millis()-gracePeriodStart)/1000), width/2, 100);
    }
    
  }
  
  // float percent = [0.0f, 1.0f]
  private float getJumpSize(float percent) {    
    if (percent < 0) { percent = 0; }
    if (percent > 1) { percent = 1; }
    
    // f(x) = -(2x-1)^2 + 1
    float factor = pow(percent * 2.0f - 1.0f, 2.0f) * -1.0f + 1.0f;
    return factor * (jump_size - size) + size;
  }
  
  //====================
  //Movement Physics
  //====================
  
  private void moveLeft() {
    xVel -= accel * (in_air ? coeff_air_drag : 1);
    if (abs(xVel) > maxVel) {
      xVel = maxVel*-1;
    }
  }
  private void moveRight() {
    xVel += accel * (in_air ? coeff_air_drag : 1);
    if (abs(xVel) > maxVel) {
      xVel = maxVel*1;
    }
  }
  private void moveUp() {
    yVel -= accel * (in_air ? coeff_air_drag : 1);
    if (abs(yVel) > maxVel) {
      yVel = maxVel*-1;
    }
  }
  private void moveDown() {
    yVel += accel * (in_air ? coeff_air_drag : 1);
    if (abs(yVel) > maxVel) {
      yVel = maxVel*1;
    }
  }
  
  private void moveJump() {
    if (in_air) { return; }
    
    in_air = true;
    time_jumping = millis();
  }
  
  private void decelerate_x() {
    //Decelerate the xVel but don't go past 0
    if (xVel != 0.0f) {
      //Debug
      if (DEBUG) {
        println("========================\nPlayer.decelerate()\n========================");
        println("Decelerating xVel: " + xVel + "\n");
      }
        
      if (xVel > 0) {
        xVel -= decel;
        if (xVel <= 0) {xVel = 0;}
      } else {
        xVel += decel;
        if (xVel >= 0) {xVel = 0;}
      }
    }
    
  }
  
  private void decelerate_y() {
    //Decelerate the yVel but don't go past 0
    if (yVel != 0.0f) {
      //Debug
      if (DEBUG) {
        println("========================\nPlayer.decelerate()\n========================");
        println("Decelerating yVel: " + yVel + "\n");
      }
      
      if (yVel > 0) {
        yVel -= decel;
        if (yVel <= 0) {yVel = 0;}
      } else {
        yVel += decel;
        if (yVel >= 0) {yVel = 0;}
      }
    }
    
  }

}

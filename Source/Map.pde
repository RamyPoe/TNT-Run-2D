class Map {
  private int jump_length = 1000;  //How long a jump should last (ms)
  private int jump_size = 60;      //Size of the player at the peak of the jump
  private float max_vel = 6;       //Maximum velocity of the player
  private float accel = 0.7;       //How fast players should accelerate
  private float decel = 0.2;       //How fast players should decelerate/friction
  
  private float coeff_restitution = 0.96f;  //How bouncy the walls are, should be less than 1
  private float coeff_air_drag = 0.3f;      //Movement factor while airborne, should be less than 1
  
  private color active_color = color(60, 200, 60);
  private color dead_color = color(131, 101, 57);

  
  //===========
  // GETTERS
  //===========
  
  public int getJumpLength() { return jump_length; }
  public int getJumpSize()   { return jump_size;   }
  public float getAccel()    { return accel;       }
  public float getDecel()    { return decel;       }
  public float getMaxVel()   { return max_vel;     }
  
  public float getRestitution() { return coeff_restitution; }
  public float getAirDrag()     { return coeff_air_drag;    }
  
  public color getActiveColor() { return active_color; }
  public color getDeadColor()   { return dead_color;   }

  
  //===========
  // SETTERS
  //===========
  
  public Map setJumpLength(int n)   { jump_length = n; return this; }
  public Map setJumpSize  (int n)   { jump_size = n;   return this; }
  public Map setAccel     (float n) { accel = n;       return this; }
  public Map setDecel     (float n) { decel = n;       return this; }
  public Map setMaxVel    (float n) { max_vel = n;     return this; }
  
  public Map setRestitution(float n) { coeff_restitution = n; return this; }
  public Map setAirDrag    (float n) { coeff_air_drag = n;     return this; }
  
  public Map setActiveColor(color c) { active_color = c; return this; }
  public Map setDeadColor  (color c) { dead_color = c;   return this; }

}

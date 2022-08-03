class Game {
  //Ground with tiles
  Grid board;
  
  //gameWinner is one of:
  //   0    (Game is running)
  //   1    (Player 1 Wins)
  //   2    (Player 2 Wins)
  private int gameWinner = 0;
  private color backgroundColor;
  
  //Players
  PlayerOne p1;
  PlayerTwo p2;
  
  //Constructor
  Game(Map map) {
    //Setup game and apply settings to board
    board = new Grid(COLS, ROWS, map.active_color);
    backgroundColor = map.dead_color;
    p1 = new PlayerOne(width/2-200, height/2);
    p2 = new PlayerTwo(width/2+200, height/2);
    
    //Apply map settings to players
    for (Player p : new Player[]{p1, p2}) {
      p.air_time = map.jump_length;
      p.jump_size = map.jump_size;
      p.maxVel = map.max_vel;
      p.accel = map.accel;
      p.decel = map.decel;
      p.coeff_restitution = map.coeff_restitution;
      p.coeff_air_drag = map.coeff_air_drag;
    }
  }
  
  public void tick() {
    //Should be images of broken tiles to seep through
    background(backgroundColor);
    
    //Draw lines and tiles
    board.display();
  
    //Check for collisions between board and players
    boolean p1Dead = board.applyCollisions(p1);
    boolean p2Dead = board.applyCollisions(p2);
    
    //check for a winner of the game
    if (!(p1Dead && p2Dead) && gameWinner == 0) {
      if (p1Dead) { gameWinner = 2; }
      if (p2Dead) { gameWinner = 1; }
    }
    
    //Print collision response
    //println("P1DEAD: " + p1Dead + "    P2DEAD: " + p2Dead + "    WINNER: " + winner);
    
    //Draw players and do maths
    p1.tick();
    p2.tick();
  }
  
  public boolean gameOver() {
    return gameWinner != 0;
  }
  
  public int getWinner() {
    if (!gameOver()) { return 0; }
    return gameWinner;
  }
  
  public void pressedKey(char key, int keyCode) {
    //Player one controls
    if (key == 'w') {
      p1.keys.press_up();
    } else if (key == 's') {
      p1.keys.press_down();
    } else if (key == 'a') {
      p1.keys.press_left();
    } else if (key == 'd') {
      p1.keys.press_right();
    } else if (key == 'q') {
      p1.keys.press_jump();
    }
    
    //Player two controls
    if (keyCode == UP) {
      p2.keys.press_up();
    } else if (keyCode == DOWN) {
      p2.keys.press_down();
    } else if (keyCode == LEFT) {
      p2.keys.press_left();
    } else if (keyCode == RIGHT) {
      p2.keys.press_right();
    } else if (key == '/') {
      p2.keys.press_jump();
    }    
  }
  
  public void releasedKey(char key, int keyCode) {
    
    //Player one controls
    if (key == 'w') {
      p1.keys.release_up();
    } else if (key == 's') {
      p1.keys.release_down();
    } else if (key == 'a') {
      p1.keys.release_left();
    } else if (key == 'd') {
      p1.keys.release_right();
    } else if (key == 'q') {
      p1.keys.release_jump();
    }
    
    //Player two controls
    if (keyCode == UP) {
      p2.keys.release_up();
    } else if (keyCode == DOWN) {
      p2.keys.release_down();
    } else if (keyCode == LEFT) {
      p2.keys.release_left();
    } else if (keyCode == RIGHT) {
      p2.keys.release_right();
    } else if (key == '/') {
      p2.keys.release_jump();
    }
  }
}

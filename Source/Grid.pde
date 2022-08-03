class Grid {
  private Tile[] tiles;
  Grill grill;
  private color active_color;
  
  Grid(int num_c, int num_r, color active_color) {
    this.active_color = active_color;
    
    fillTiles(num_c, num_r, width, height);
    grill = new Grill(num_c, num_r, width, height);
  }
  
  private void fillTiles(int tc, int tr, int w, int h) {
    //Debug
    if (DEBUG) {
      println("========================\nGrid.fillTiles()\n========================");
      println("WIDTH: " + w + "   HEIGHT: " + h + "\n");
    }
    
    
    //Calc sizes
    tiles = new Tile[tc*tr];
    int size_w = w/tc;
    int size_h = h/tr;
    
    
    //WARNING
    if (size_w != size_h) {
      println("===========================\nWARNING\n===========================\nGRID DIMENSIONS DON'T ALLOW FOR THE USE OF SQUARE TILES! DO UR MATH!");
    }
    
    //Add each tile to list
    for (int i = 0; i < tr; i++) {
      for (int j = 0; j < tc; j++) {

        //Calculate center of (x, y) position for tile, give it w & h
        Tile tile = new Tile(j*size_w+size_w/2.0f, i*size_h+size_h/2.0f, size_w, size_h);
        
        //Starting params
        tile.state = 1;
        tile.setColor(active_color);
        
        //Save
        tiles[i*tc+j] = tile;
        
        //Debug
        if (DEBUG) {
          println("========================\nGrid.fillTiles()\n========================");
          println("ADDING INDEX: " + (i*tc+j) + " / " + (tiles.length-1) + "\n");
        }
        
      }
    }
  }
  
  
  public void display() {
    //Draw Tiles
    for (int i = 0; i < tiles.length; i++) {
      //Draw each tile
      tiles[i].tick();      
    }
    
    //Draw grid overlay
    grill.display();
    
  }
  
  //Returns true if the player has fallen into hole
  public boolean applyCollisions(Player p) {
    //If player is in the air it cannot collide
    if (p.inAir()) {
      return false;
    }
    
    boolean fell_down = true;
    
    //Go through list of all tiles
    for (int i = 0; i < tiles.length; i++) {
      //If the tiles is not already ran over
      if (tiles[i].state == 3) {
        continue;
      }
      
      //Check hitboxes
      if (tiles[i].hbox.collide(p.hbox)) {
        if (tiles[i].state == 1) { tiles[i].setStateBreaking(); }
        fell_down = false;
      }
      
    }
    
    return fell_down;
  }
  
}

class MainMenu {
  //Dividing lines
  //private final int divider_centerx_offset = 400;
  
  PFont font = createFont("Arial", 20, true);;
  
  //background tnt
  PImage tntImg = loadImage("assets/menu/tnt.jpg");
  private final int tnt_w = 200;
  private final int tnt_h = 200;
    
  //Banner
  PImage bannerImg = loadImage("assets/menu/banner1.png");
  private final int banner_w = 630; //630
  private final int banner_h = 143; //143
  
  private final int banner_centery_offset = 260; //260
  
  //Displaying win/loss players
  private final int player_center_offset = 290;
  private final int player_y = 600;
  private final int player_size = 120;
  private final PImage smugImg = loadImage("assets/menu/smug-layer.png");
  private final PImage madImg = loadImage("assets/menu/mad-layer.png");
  private final int face_img_size = 100;
  
  //Buttons
  Button button_play =     new Button(width/2, height/2 - 65,  360, 120, "PLAY")
                               .setBackgroundColor(color(220,20,20)) //240
                               .setBorderColor(color(20)) //20
                               .setTextColor(color(250)) //20
                               .setHoverColor(color(185,20,20)) //220
                               .setBorderThickness(4) //4
                               .setTextSize(64); //32
                               
  Button button_map =      new Button(width/2, height/2 + 60,  270, 70,  "Select Map")
                               .setBackgroundColor(color(20,20,220))
                               .setBorderColor(color(20))
                               .setTextColor(color(250))
                               .setHoverColor(color(20,20,185))
                               .setBorderThickness(4)
                               .setTextSize(32);
                               
  Button button_controls = new Button(width/2, height/2 + 150, 270, 70,  "Controls")
                               .setBackgroundColor(color(20,20,220))
                               .setBorderColor(color(20))
                               .setTextColor(color(250))
                               .setHoverColor(color(20,20,185))
                               .setBorderThickness(4)
                               .setTextSize(32);
  
  //Draw all components to the screen
  public void display() {
    //Background color
    background(25);
    
    //TNT Images
    imageMode(CENTER);
    image(tntImg, width/5, height/2, tnt_w, tnt_h);
    image(tntImg, 4*width/5, height/2, tnt_w, tnt_h);
        
    //Banner
    imageMode(CENTER);
    image(bannerImg, width/2, height/2-banner_centery_offset, banner_w, banner_h);
    
    //Buttons
    button_play.display();
    button_map.display();
    button_controls.display();
    
    //Previous winner
    drawPlayerOutlines();
    
    textAlign(CENTER, CENTER);
    textSize(30);
    fill(40);
    imageMode(CENTER);
    
    //Display angry and smug faces
    switch (winner) {
      
      case 1:
        image(smugImg, width/2-player_center_offset, player_y, face_img_size, face_img_size);
        image(madImg, width/2+player_center_offset, player_y, face_img_size, face_img_size);
        fill(255);
        text("Player 1 wins!", width/2, height*6/7);
        break;
        
      case 2:
        image(madImg, width/2-player_center_offset, player_y, face_img_size, face_img_size);
        image(smugImg, width/2+player_center_offset, player_y, face_img_size, face_img_size);
        fill(255);
        text("Player 2 wins!", width/2, height*6/7);
        break;
        
      default:
        image(madImg, width/2-player_center_offset, player_y, face_img_size, face_img_size);
        image(madImg, width/2+player_center_offset, player_y, face_img_size, face_img_size);
        fill(255);
        text("N/A", width/2, height*6/7);
    }

    //Shoes lifetime record of wins for each player
    textFont(font);
    fill(255);
    text("Player 1 wins: " + p1Wins, 125, height*6/7);
    textFont(font);
    fill(255);
    text("Player 2 wins: " + p2Wins, width-125, height*6/7);    
  }
  
  private void drawPlayerOutlines() {
    ellipseMode(CENTER);
    stroke(0); strokeWeight(2);
    
    fill(255, 60, 60);
    ellipse(width/2-player_center_offset, player_y, player_size, player_size);
    
    fill(20, 120, 235);
    ellipse(width/2+player_center_offset, player_y, player_size, player_size);
  }
  
}

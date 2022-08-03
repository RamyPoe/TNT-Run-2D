class HelpMenu{

  PImage helpImg = loadImage("assets/menu/helpScreen.png");

  Button button_back =     new Button(100/2 + 10, 50/2 + 10, 100, 50, "BACK")
                               .setBackgroundColor(color(220,20,20)) //240
                               .setBorderColor(color(20)) //20
                               .setTextColor(color(250)) //20
                               .setHoverColor(color(185,20,20)) //220
                               .setBorderThickness(4) //4
                               .setTextSize(24); //32
  
  
  public void display() {
    //Background
    background(25);
    
    //Writing
    textSize(48);
    fill(220);
    stroke(220);
    textAlign(CENTER, CENTER);
    
        
    //CONTENT
    text("Player 1", 240, 210);
      line(150, 240, 330, 240);
    
    text("W - up",     240, 290);
    text("A - left",   240, 350);
    text("S - down",   240, 410);
    text("D - right",  240, 470);
    text("Q - jump",   240, 530);
    
    
    text("Player 2", 540, 210);
      line(450, 240, 630, 240);
      
    text("^ - up",     540, 290);
    text("< - left",   540, 350);
    text("v - down",   540, 410);
    text("> - right",  540, 470);
    text("/ - jump",   540, 530);
    
    rectMode(CORNERS);
    textSize(32);
    textAlign(LEFT, TOP);
    text("The objective is to survive longer than your opponent.\n\nIf you stay on a tile for too long it will break, so be sure to continue moving!\n\nStand on a broken tile and you will lose!",
        740, 190,
        1130, 700);
    
 
    //Buttons
    button_back.display();
  }

}

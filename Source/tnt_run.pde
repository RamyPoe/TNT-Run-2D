import java.io.BufferedWriter;
import java.io.FileWriter;

//==========================
// VARIABLES/CONSTANTS
//==========================

public static final boolean DEBUG = true;
public static boolean mouseDown = false;

//MENU is one of:
//   1    (Main Menu)
//   2    (Map selector)
//   3    (Controls)
//   4    (Game)
public static int MENU = 1;

public static final int COLS = 24;  //24
public static final int ROWS = 14;   //14

public int fade = 0;
public boolean fadeIn = false;
public boolean fadeOut = false;
public int changeTo = 1;

Game game;
MainMenu menu;
MapMenu mapSelect;
HelpMenu helpScreen;

public static int winner = 0;

int p1Wins, p2Wins = 0;
public static final String RECORD_FILE_PATH = "assets/game/winlogs.txt";

//==========================




void setup() {
  //Setup display
  size(1200, 700);
  //fullScreen();
  frameRate(60);
  
  //Initial setup for classes
  menu = new MainMenu();
  game = new Game(new Map());
  mapSelect = new MapMenu();
  helpScreen = new HelpMenu();

  //Read all time score from files
  int[] prevCount = parseFile(RECORD_FILE_PATH);
  p1Wins = prevCount[0];
  p2Wins = prevCount[1];
  
  
  //For click checking
  mouseDown = mousePressed;
}

void draw() {
  
  switch (MENU) {
    
    case 1:  //MAIN MENU
    
      menu.display();
      
      if (menu.button_play.clicked() && changeTo == 1) {
        game = new Game(mapSelect.getMap());
        fadeTo(4);
        
      }
      if (menu.button_map.clicked() && changeTo == 1) {
        fadeTo(2);
      }
      if (menu.button_controls.clicked() && changeTo == 1) {
        fadeTo(3);
      }   
      
      fadeAnim();
      break;
      
    case 2:  //MAP SELECT
    
      mapSelect.display();
      int mapClicked = mapSelect.checkMapClicked();
      if (mapClicked != -1) {
        mapSelect.setMap(mapClicked);
        
        if (changeTo == 2) {
          fadeTo(1);
        }
      }
      
      fadeAnim();
      break;
      
    case 3:  //CONTROL HELP
    
      helpScreen.display();
      if (helpScreen.button_back.clicked() && changeTo == 3){
        fadeTo(1);
      }
      
      fadeAnim();      
      break;
      
    case 4:  //GAME
    
      game.tick();
      
      if (game.gameOver()) {
        winner = game.getWinner();
        
        //Only run once
        if (changeTo == 4) {
          //Update local record
          switch (winner) {
            case 1:
              p1Wins++;
              break;
            case 2:
              p2Wins++;
              break;
          }
          
          //Write new record to file
          writeRecordFile(p1Wins, p2Wins);
          
          //Change menu screen
          fadeTo(1);
        }
      }
      
      fadeAnim();
      break;
  }
  
  //For click detection
  mouseDown = mousePressed;
}



//========================================================

void keyPressed() {
  game.pressedKey(key, keyCode);
}

void keyReleased() {
  game.releasedKey(key, keyCode);
}

//========================================================

/*
How the state of the game or menu was reached
initiates the fade animation, starting from fade out
*/
void fadeTo(int menu) {
  changeTo = menu;
  fadeOut = true;
  fadeIn = false;
  fade = 0;
}

/*
First fades out, drawing a rectangle getting darker
then fades in, drawing a rectangle getting lighter
*/
void fadeAnim() {
    //FADE IN
    if (fadeIn) {
      if (fade > 0) {
        fade -= 5;
      } else {
        fade = 0;
        fadeIn = false;
        fadeOut = false;
      }
    }
    
    //FADE OUT
    if (fadeOut) {
      if (fade < 255) {
        fade += 5;
      } else {
        MENU = changeTo;
        fadeOut = false;
        fadeIn = true;
        fade = 255;
      }
    }
    
    if (fadeIn || fadeOut) {
      rectMode(CORNER);
      noStroke();
      fill(0, fade);
      rect(0, 0, width, height);
    }
}




/*
Reads and parses data from highscore file
Returns an int[] with each player's score
*/
int[] parseFile(String filePath) {
  String[] scores = readFile(filePath).split(",");
  return new int[]{Integer.parseInt(scores[0]), Integer.parseInt(scores[1])};
}

/*
Takes in player win records and updates
the file with the new values
*/
void writeRecordFile(int win1, int win2) {
  String output = "" + win1 + "," + win2;
  writeFile(output, RECORD_FILE_PATH);
}


//======================================================================
//BASIC IO

public String readFile(String fileName){
  BufferedReader reader = createReader(fileName);
  String line = null;
  try {
    line = reader.readLine();
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
  return line;
}

public void writeFile(String text, String FileName) {
  PrintWriter output = createWriter(FileName);
  output.println(text);
  output.flush();
  output.close();
}

//Initial Screen = 0
//Game Screen = 1
//Death Screen = 2

//variables
//custom objects made from classes I made
SpaceShip spaceShip;
Alien enemy;

//arrayLists to manage many of the same objects
ArrayList <bullet> bullets;
ArrayList <Alien> enemies;
ArrayList <Integer> scoreList;

int life = 3;
int enemyNum = 10;
int screen = 0;
double difficultyMultiplyer = 1;

//constants
int j=0;
int n=0;
public int score=0;

//input variable
boolean keyPressedSpace = true;

//image variables
PImage titleBg;
PImage spaceBg;
PImage enemyPic0;
PImage enemyPic1;
PImage enemyPic2;
PImage playerPic;

//custom font variable
PFont retro;

//Setup function runs once
void setup() {
  //loading custom images
  retro = createFont("emulogic.ttf", 32);
    
  titleBg = loadImage("galaga.jpg");
  titleBg.resize(700,600);
  
  enemyPic0 = loadImage("enemy0.jpg");
  enemyPic0.resize(25,25);

  enemyPic1 = loadImage("enemy1.jpg");
  enemyPic1.resize(25,25);

  enemyPic2 = loadImage("enemy2.jpg");
  enemyPic2.resize(25,25);

  playerPic = loadImage("player.jpg");
  playerPic.resize(25,25);
  
  //game elements
  bullets = new ArrayList();
  enemies = new ArrayList();
  scoreList = new ArrayList();
  
  spaceShip = new SpaceShip();
  
  size(700, 600); 
  
  spawnAliens();
  scoreList.add(score);
}
//loop function
void draw() {
//if statements that change current screen
if(screen == 0){
    initScreen();
    j=0;
} 
else if(screen == 1){
    gameScreen();
    //gives player another life and respawns enemies when they all die, also increases difficulty counter
    if(enemies.size() < 1){
    spawnAliens();
    spaceShip.addLife();
    difficultyMultiplyer = difficultyMultiplyer - .001;
    }
    //checks to see if the player has gone off the map and places them on the opposite side
    else if(spaceShip.getX() < 0){
      spaceShip.x = 700;
    }
    else if(spaceShip.getX() > 700){
      spaceShip.x = 0;
    }
    
}
else if(screen == 2){
      if(j==0){
      gameOverScreen();
      spaceShip.setLife(2);
      score = 0;
      j = 1;
      }
    //resets the enemies and bullets  
    for(int i = 0; enemies.size() > i; i++){
      enemies.remove(i);
      
    }
    for(int i = 0; i < bullets.size(); i++){
      bullets.remove(i);
    }
}
}

//Screen functions
void initScreen(){
  background(titleBg);
  
  //intro text
  textAlign(CENTER);
  fill(255,20,147);
  textFont(retro);
  textSize(22);
  text("Click to start", 330, 300);
}
void gameScreen(){  
  background(0);
  
  //bottem text
  textAlign(DOWN);
  fill(255,20,147);
  textFont(retro);
  text("Galaga", 250, 580);
  
  textAlign(DOWN);
  fill(255,20,147);
  textFont(retro);  
  textSize(20);
  text("Score:" + score, 10, 580);
  
  textAlign(DOWN);
  fill(255,20,147);
  textFont(retro);
  textSize(20);
  text("Lives:" + spaceShip.getLife(), 530, 580);
  
  spaceShip.run();
  playerMovement();
  moveAliens();
  moveBullets();
}
void gameOverScreen() {
  background(titleBg);
  difficultyMultiplyer = 1;
  
  keepScore();
}

//Player Inputs
public void mousePressed() {
  if(screen == 0) {
    screen = 1;
  }
  else if(screen == 2 || screen == 3){
    screen = 0;  
    
  }
}

public void playerMovement(){
  if(keyPressed) {
    if(key == 'a') {
      spaceShip.x -=5;
     
    }
    else if(key == 'd'){
      spaceShip.x +=5;
    }
  }
}
  void keyPressed(){ 
    if(key == ' ' && keyPressedSpace == true) {
     spaceShip.shoot();
     keyPressedSpace = false;
   }
  }
  void keyReleased() {
    if(key == ' ') {
      keyPressedSpace = true;
    }
  }
  
  
//object functions
//adds aliens to their arraylist
void spawnAliens(){
  for(int i = 0; i < 20; i++){
    float x = width*.1 + i%enemyNum*50;
    float y = 25 + int(i/enemyNum)*60;
    enemies.add(new Alien(x,y));
  }
}
//makes the aliens move 
void moveAliens() {
  for(int i = 0; i < enemies.size(); i++){
    Alien enemy = (Alien) enemies.get(i);
    enemy.move();
    enemy.display();
    enemy.checkHit();
   
    if (random(1) > (.995*difficultyMultiplyer) ) {
    enemy.shoot();
    }
  }
}
//moves and adds bullets to arraylist
void moveBullets() {
  for (int i = 0; i < bullets.size(); i++) {
    bullet b = (bullet) bullets.get(i);
    b.move();
    b.display();
  }
}
//adds current game score to ending screen and also resets it once the screen gets full
void keepScore(){
  scoreList.add(score);
  for (int i = 0; i < scoreList.size(); i++) {
    textAlign(CENTER);
    fill(255,20,147);
    textFont(retro);
    textSize(22);
    text("you die", 330, height - 40);
    text("Click to play again", 330, height - 10);
    text("Game "+ i + " Score: " + scoreList.get(i), 330, 50*i);    
  }
  if(scoreList.size() > 5){
    for(int i = 0; i < scoreList.size(); i++){
      scoreList.remove(i);
    }
    for(int i = 0; i < scoreList.size(); i++){
      scoreList.remove(i);
    }
  }
}

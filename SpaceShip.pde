
class SpaceShip {
  float x;
  float y;
  int lives;
  PImage player;
  
  SpaceShip(){
    this.x = width/2;
    this.y = 500;
    this.lives = life;
    this.player = playerPic;
  }
  void run(){
    display();
    checkHit();
  }
  
  void display(){
  //  rect(this.x-10, this.y-10, 25, 25);
    image(player,this.x-10,this.y-10);

  }
  
  float getX(){
    return x;
  }

  void shoot(){
    bullet b = new bullet(this.x,this.y-20,-5);
    bullets.add(b);
  }
  
  void addLife(){
  lives = lives + 1;
  }
  int getLife(){
  return lives;
  }
  void setLife(int life){
  lives = life;
  }
  
  void die(){
    screen = 2;
    lives = 3;
  }
  void checkHit(){
    for(int i = 0; i < bullets.size(); i++){
      bullet b = (bullet) bullets.get(i);
      float distBetween = dist(b.x, b.y, this.x, this.y);
     
      if(distBetween < 15 && b.speed > 0){
        lives = lives - 1;
        bullets.remove(b);

         if(lives == 0){
           this.die();
         }
      }
    }
  }
  
}

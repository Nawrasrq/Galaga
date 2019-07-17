
class Alien {  
   float x;
   float y;
   float speed;
   PImage enemy0;    
   PImage enemy1;
   PImage enemy2;
   int random = (int)random(1,4);
   
   Alien(float x, float y) {
     this.x = x;
     this.y = y;
     this.speed = 2;
     
     this.enemy0 = enemyPic0;
     this.enemy1 = enemyPic1;
     this.enemy2 = enemyPic2;
   }
   
   void run() {  
     display();
     move();
   }
   
   void move() {
     this.x+=this.speed;
     if(this.x > width*.9) {
        this.x = width*.9;
        this.speed *= -1;
        this.y+=30;
     }

     if(this.x < width*.1) {
        this.speed*=-1;
        this.x = width*.1;
        this.y+=30;
     }
  }
  float getX(){
    return x;
  }
  float getY(){
    return y;
  }
  
   void display(){
   rect(this.x, this.y, 25, 25);
     
     if(random == 1){
       image(enemy0,this.x,this.y);
     }
     else if(random == 2){
       image(enemy1,this.x,this.y);
     }
     else if(random == 3){
       image(enemy2,this.x,this.y);
     }
   }
   
   void checkHit(){
     for(int i = 0; i < bullets.size(); i++){
       bullet b = (bullet) bullets.get(i);
       float distBetween = dist(b.x, b.y, this.x, this.y);
     
       if(distBetween < 15 && b.speed < 0){
          enemies.remove(this);
          score = score + 1;
          bullets.remove(b);
       }

     }
   }
   
   void shoot(){
   bullet b = new bullet(this.x, this.y, 5);
   bullets.add(b);
   }  
}

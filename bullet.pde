class bullet {
  float speed;
  float x;
  float y;
  
  bullet(float x, float y, float speed){
    this.x = x;
    this.y = y;
    this.speed = speed; 
  }
  void run(){
    display();
    move();
  }
  void display(){
    noStroke();
    fill(255,0,0);
    rect(this.x, this.y, 5,20);
    stroke(0);
  }
  void move(){
    this.y+=this.speed;
  }
}

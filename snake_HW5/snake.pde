float s = 5;//default moving speed of snake 
float r = s*4;
ArrayList snake = new ArrayList(); 
PVector food = new PVector(); 
PVector vel = new PVector(s,0); 
PImage bg;//for uploading image

void newFood(){
  food = new PVector (mouseX,mouseY);// make food come up at which the mouse stop
}

void setup(){
  size(385,386);
  smooth();
  frameRate(20);
  rectMode(CENTER);//make the ract be located by its center
  bg = loadImage("background.jpg");
  
  snake.add(new PVector(width/2, height/2));//0 head
  snake.add(new PVector());//1 body
  snake.add(new PVector());//2 body
  newFood();
 
}

void draw(){
  background(bg);
  PVector head = (PVector)snake.get(0);
  head.add(vel);
  
  if (head.x > width){
    noLoop();
  }else if (head.x < 0){
    noLoop();
  }
  if (head.y > height){
    noLoop();
  }else if (head.y < 0){
    noLoop();
  } 
  
  
  for (int i=snake.size()-1; i>0; i--){
    PVector cur = (PVector)snake.get(i);
    fill(color(255,0,0));
    noStroke();
    ellipse(cur.x, cur.y, r, r);
    //above are for snake's body
   
   PVector prev = (PVector)snake.get(i-1);
   cur.x = prev.x;
   cur.y = prev.y;
   
   
  }
  //make one follow another
   fill(color(0,0,102));//stroke(0);strokeWeight();
   ellipse(head.x, head.y, r, r);
  // above are for snake's head
  
  
  if(head.dist(food) < r){
    snake.add(new PVector(head.x, head.y));
    newFood();
    //eat food and produce new food
  }else {
    fill(color(0,120,200)); noStroke();
    rect(food.x,food.y, r,r);
    noFill(); stroke(255); strokeWeight(2);
    rect(food.x,food.y, r, r);
  }
}

void keyPressed(){ 

    if (vel.x == 0){ 
      if (key == 'a'){ 
        vel = new PVector(-s,0); 
      }else if (key == 'd'){
        vel = new PVector(s,0); 
      }
    } 
    if (vel.y == 0){ 
      if (key == 'w'){
       vel = new PVector(0,-s); 
      }else if (key == 's') {
        vel = new PVector(0,s); 
      }
     } 
   }


  

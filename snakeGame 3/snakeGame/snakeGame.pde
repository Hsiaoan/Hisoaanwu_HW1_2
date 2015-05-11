Snake[] snake = new Snake[1];       //the snake
Food[] food = new Food[1];          //the food that the snake eats, appears on screen one at a time
Box[] box = new Box [3];            //the spaces where the snake hunts
Portal[] portal = new Portal [4];   //the portals that the snake uses to travel between spaces (boxes)
Note[] note = new Note [2];         //the note that displays when the snake dies

boolean hitBox = false;             //turns "true" when the snake hits the border of the boxes
boolean hitPortal = false;          //turns "true" when the snake hits one of the portal
boolean foodOK = false;             //turns "true" if the location of the food (x, y) is in the boundry of the boxes
boolean messageDisplayed = false;   //turns "true" if a message is displayed
PVector oxygenBox[] = new PVector[20]; //the oxygen bar which accumulates overtime
int oxygenCount = 0; //oxygen starts with 0
int secondCount = 0; //player gains 1 oxygen every 50 frames
int life = 5;
int eggCount = 0; //no use right now
int score = 0; //QUESTION: CAN WE MAKE IT DISPLAY 000010201 INSTEAD OF SIMPLY 10201?


//make the game fullscreen
boolean sketchFullScreen(){
  return true;
}

//setup the canvas
void setup(){
  size(1024, 768);
  smooth();
 
  //use this line of code to adjust the speed of the game  
  frameRate(15); 
  
  //creat a new snake head, the first food, the snake's body (which contains 5 
  snake[0] = new Snake (30, 30, 12, 0);
  food[0] = new Food (random(width), random(height), 12);
  snake[0].snakeBody.add(new PVector(snake[0].headLocation.x, snake[0].headLocation.y));
  for (int i=0; i<6; i++){ //change the number to change the length of the original snake
    snake[0].snakeBody.add(new PVector());
  }
  
  //setting up the snake's moving spaces
  box[0] = new Box (12, 12, 252, 252);
  box[1] = new Box (300, 12, 456, 300);
  box[2] = new Box (12, 360, 720, 252);
  println (box.length);
  
  //setting up  the pairs of portals
  portal[0] = new Portal (264, 30, 12, 480, 0, true, 60);
  portal[1] = new Portal (732, 408, 12, 204, 1, true, 60);
  portal[2] = new Portal (352, 312, 640, 360, 2, false, 60);
  portal[3] = new Portal (40, 264, 500, 12, 2, false, 60);
  
  //make sure the egg is inside the boundry of the boxes
  while (foodOK == false){
    food[0].newFood();
    for (int i = 0; i < box.length && foodOK == false; i++) {
      if ( food[0].location.x >= box[i].originPoint.x && food[0].location.x <= box[i].originPoint.x + box[i].size.x
        && food[0].location.y >= box[i].originPoint.y && food[0].location.y <= box[i].originPoint.y + box[i].size.y) {
          println("booting:", i, "times");
        
        foodOK = true;
      }else{
        foodOK = false;
      }
    }      
  }  
  

  for (int i = 0; i < oxygenBox.length; i++) {
    oxygenBox[i] = new PVector(300+i*10, 50);
  }
  
  
  //setting up the note
  note[0] = new Note (width/2, height/2, 200, 120, 70, 30, "Your Snake Died!", "Try Again");//some more lives left
  note[1] = new Note (width/2, height/2, 200, 120, 70, 30, "Game Over!", "Exit Game");//no more life left

}


void draw(){
  background(200);
  
  //display life and score
  fill(255);
  textSize(32);
  text("Life:", 60, 75);
  text(life, 140, 75);
  textAlign(RIGHT);
  text(score, width - 60, 75);

  
  rectMode(CORNERS);
  
  //draw the oxygen bar
  strokeWeight(1);
  stroke(0, 0, 255);
  noFill();
  rect(300, 50, 700, 60);
  fill(0, 0, 255);
  noStroke();
  for (int i=0; i < oxygenCount; i++) {
    rect(oxygenBox[i].x, oxygenBox[i].y, oxygenBox[i].x+10, oxygenBox[i].y+10);
  }
  
  
  //a line that separates console and game area
  stroke(255);
  line (0, 90, 1024, 90);  
  
  pushMatrix();
  translate(115, 120);
  
  //draw the boxes
  stroke(0);
  strokeWeight(3);
  noFill();
  rectMode(CORNER);
  for (int i = 0; i < box.length; i++) {
    rect(box[i].originPoint.x, box[i].originPoint.y, box[i].size.x, box[i].size.y);
  }
  
  
  //draw the portals
  for (int i = 0; i < portal.length; i++) {
    //set the portal colors
    if (i==0){
      stroke(255,225,0);
    }else if (i == 1) {
      stroke(255, 0, 255);
    }else if (i == 2) {
      stroke(0, 255, 255);
    }else if (i == 3) {
      stroke(0, 200, 0);
    }
    
    strokeWeight(5);
    
    //vertical portals
    if (portal[i].type){
      line(portal[i].positionA.x, portal[i].positionA.y, portal[i].positionA.x, portal[i].positionA.y + portal[i].size);
      line(portal[i].positionB.x, portal[i].positionB.y, portal[i].positionB.x, portal[i].positionB.y + portal[i].size);
    
    //horizontal portals  
    }else if (!portal[i].type){
      line(portal[i].positionA.x, portal[i].positionA.y, portal[i].positionA.x + portal[i].size, portal[i].positionA.y);
      line(portal[i].positionB.x, portal[i].positionB.y, portal[i].positionB.x + portal[i].size, portal[i].positionB.y);  
    }  
  }
  
  //update the status of the snake
  snake[0].update();
  
  //draw the snake's head
  stroke(0);
  strokeWeight(0);
  fill(255);
  rectMode(CENTER);
  rect(snake[0].headLocation.x, snake[0].headLocation.y, snake[0].size, snake[0].size);
  
  //draw the snake's body
  for (int i = snake[0].snakeBody.size() - 1; i > 0; i--){
    PVector current = (PVector)snake[0].snakeBody.get(i);

    fill(color(100));
    stroke(255); 
    strokeWeight(1);
    rectMode(CENTER);
    rect(current.x, current.y, snake[0].size, snake[0].size); 

    PVector next = (PVector) snake[0].snakeBody.get(i-1);
    current.x = next.x;
    current.y = next.y;    
  }
  
  
  //check if snake runs into itself
  for (int i = snake[0].snakeBody.size()-1; i > 1 ; i--){
    if (snake[0].headLocation.dist((PVector) snake[0].snakeBody.get(i)) < food[0].r){
      if (life == 0){
        note[1].displayNote();
      }else{
        note[0].displayNote();
      }
        
      messageDisplayed = true;
    }  
  }
  
  //snake eats the food (it is very important that this part goes after checking if the snake runs into itself)
  if((abs(snake[0].headLocation.x - food[0].location.x) < food[0].r) && (abs(snake[0].headLocation.y - food[0].location.y) < food[0].r)){
    snake[0].snakeBody.add(new PVector(snake[0].headLocation.x, snake[0].headLocation.y));
    foodOK = false;
    score = score + 100;
    
    //again, make sure the egg is in the boundry of the boxes
    while (foodOK == false){
      food[0].newFood();
      for (int i = 0; i < box.length && foodOK == false; i++) {
        if ( food[0].location.x >= box[i].originPoint.x && food[0].location.x <= box[i].originPoint.x + box[i].size.x
          && food[0].location.y >= box[i].originPoint.y && food[0].location.y <= box[i].originPoint.y + box[i].size.y) {
          println ("rebooting:", i, "times");
          foodOK = true;
        }else{
          foodOK = false;
        }
      }      
    }
  //if it doesn't eat the egg, just keep going   
  }else{
    fill(color(0,122,200));
    noStroke(); 
    rect(food[0].location.x, food[0].location.y, food[0].r, food[0].r); 
    stroke(255,255,255);
    strokeWeight(1);
    rect(food[0].location.x, food[0].location.y, food[0].r, food[0].r); 
    foodOK = false;
  }
  
  //check if snake goes out of bound
  if (snake[0].headLocation.x + 6 > width || snake[0].headLocation.x - 6 < 0 || snake[0].headLocation.y + 6 > height || snake[0].headLocation.y - 6 <0){
    note[0].displayNote();
    messageDisplayed = true;
  }
  
  //check edges if snake hits the wall of the boxes
  for (int i = 0; i < box.length; i++){
    if ( abs(snake[0].headLocation.x - box[i].originPoint.x) <= 6 || abs(snake[0].headLocation.x - (box[i].originPoint.x + box[i].size.x)) <= 6 ) {
      if (snake[0].headLocation.y >= box[i].originPoint.y && snake[0].headLocation.y <= box[i].originPoint.y + box[i].size.y) {
        hitBox = true;
      }
    }else if(abs(snake[0].headLocation.y - box[i].originPoint.y) <= 6 || abs(snake[0].headLocation.y - (box[i].originPoint.y + box[i].size.y)) <= 6) {
      if (snake[0].headLocation.x >= box[i].originPoint.x && snake[0].headLocation.x <= box[i].originPoint.x + box[i].size.x) {
        hitBox = true;
      }
    }
  }
  
  //check if the snake hits a portal
  if (hitBox) {
    for (int j = 0; j < portal.length; j++) {

      //if the snake hits the portal from left to right
      if (abs(snake[0].headLocation.x - portal[j].positionA.x) <= 6 ) {
        
        //check if the Y axis of the snake's head is in the boundry of the portal
        if ( snake[0].headLocation.y >= portal[j].positionA.y && snake[0].headLocation.y <= portal[j].positionA.y + portal[j].size) {
          
          hitPortal = true;
          hitBox = false;
          
          //snake goes through the portal
          snake[0].headLocation.x = portal[j].positionB.x;
          snake[0].headLocation.y = portal[j].positionB.y + (snake[0].headLocation.y - portal[j].positionA.y);
        
        }
      //if the snake hits the portal from right to left 
      }else if (abs(snake[0].headLocation.x - portal[j].positionB.x) <= 6 ) {

        //check if the Y axis of the snake's head is in the boundry of the portal
        if ( snake[0].headLocation.y >= portal[j].positionB.y && snake[0].headLocation.y <= portal[j].positionB.y + portal[j].size) {
          
          hitPortal = true;
          hitBox = false;
          
          //snake goes through the portal
          snake[0].headLocation.x = portal[j].positionA.x;
          snake[0].headLocation.y = portal[j].positionA.y + (snake[0].headLocation.y - portal[j].positionB.y);
            
        }
                                            
      //if the snake hits the portal from top to bottom
      }else if (abs(snake[0].headLocation.y - portal[j].positionA.y) <= 6) {

        //check if the X axis of the snake's head is in the boundry of the portal
        if ( snake[0].headLocation.x >= portal[j].positionA.x && snake[0].headLocation.x <= portal[j].positionA.x + portal[j].size) {

          hitPortal = true;
          hitBox = false;
          
          //snake goes through portal
          snake[0].headLocation.y = portal[j].positionB.y;
          snake[0].headLocation.x = portal[j].positionB.x + (snake[0].headLocation.x - portal[j].positionA.x);
        }
 
      //if the snake hits the portal from bottom to top
      }else if (abs(snake[0].headLocation.y - portal[j].positionB.y) <= 6 ) {

        //check if the X axis of the snake's head is in the boundry of the portal
        if ( snake[0].headLocation.x >= portal[j].positionB.x && snake[0].headLocation.x <= portal[j].positionB.x + portal[j].size) {

          hitPortal = true;
          hitBox = false;
          
          //snake goes through portal
          snake[0].headLocation.y = portal[j].positionA.y;
          snake[0].headLocation.x = portal[j].positionA.x + (snake[0].headLocation.x - portal[j].positionB.x);
        
        }   
      }
    }
  }
  
  if (hitBox) {
    
    if (life == 0){
      note[1].displayNote();//game over!
    }else{
      note[0].displayNote();//play another life
    }
    messageDisplayed = true;
  }
  
  
  
  
  
  popMatrix();
  
  textMode(CENTER);
  textAlign(LEFT);
  fill(255, 255, 0);
  textSize(12);
  text(mouseX, mouseX+10, mouseY);
  text(mouseY, mouseX+10, mouseY+10);
  
  if (secondCount < 100) {
    secondCount ++;
  }else if (secondCount == 100 && oxygenCount < 20){
    secondCount =0;
    oxygenCount++;
  }
  
  score++;
  
  

}

void keyPressed() { 
  if (key == CODED) { 
    if (snake[0].velocity.x == 0) { 
      if (keyCode == LEFT) {
        snake[0].velocity = new PVector(-abs(snake[0].velocity.y),0); 
      }else if (keyCode == RIGHT) {
        snake[0].velocity = new PVector(abs(snake[0].velocity.y),0); 
      }
    }
    
    if (snake[0].velocity.y == 0) { 
      if (keyCode == UP) {
        snake[0].velocity = new PVector(0,-abs(snake[0].velocity.x)); 
      }else if (keyCode == DOWN) {
        snake[0].velocity = new PVector(0,abs(snake[0].velocity.x)); 
      }
    } 
  } 
}

void mouseClicked() {
  if (mouseX >= width/2-35 
   && mouseX <= width/2 + 35 && mouseY>=height/2 
   && mouseY<=height/2+30 
   && messageDisplayed == true){
    if (life ==0 ){
      exit();
    }
     
    for (int i = snake[0].snakeBody.size()-1; i >= 0 ; i--){
      snake[0].snakeBody.remove(i);
    }
    
    println(snake[0].snakeBody.size());
    
    snake[0].headLocation = new PVector (30, 30);
    snake[0].velocity = new PVector (12, 0);
    snake[0].snakeBody.add(new PVector(snake[0].headLocation.x, snake[0].headLocation.y));
    
    for (int i=0; i<10; i++){
      snake[0].snakeBody.add(new PVector());
    }
    
    foodOK = false;
    while (foodOK == false){
      food[0].newFood();
      for (int i = 0; i < box.length && foodOK == false; i++) {
        if ( food[0].location.x >= box[i].originPoint.x && food[0].location.x <= box[i].originPoint.x + box[i].size.x
          && food[0].location.y >= box[i].originPoint.y && food[0].location.y <= box[i].originPoint.y + box[i].size.y) {
            println("booting:", i, "times");
          
          foodOK = true;
        }else{
          foodOK = false;
        }
      }      
    }
     
    loop();
    //reset everything
    hitBox = false;
    messageDisplayed = false;
    oxygenCount = 0;
    secondCount = 0;
    
    //lose one life
    life --;
  }
}

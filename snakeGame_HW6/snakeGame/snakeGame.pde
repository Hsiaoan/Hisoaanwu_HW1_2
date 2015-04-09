Snake[] snake = new Snake[1];
Food[] food = new Food[1];

void setup(){
  size(800, 600);
  smooth(); 
  frameRate(25); 
  rectMode(CENTER);
  snake[0] = new Snake (width/2, height/2, 12, 0);
  food[0] = new Food (random(width), random(height), 12);
  snake[0].snakeBody.add(new PVector(snake[0].headLocation.x, snake[0].headLocation.y));
  snake[0].snakeBody.add(new PVector());
  snake[0].snakeBody.add(new PVector());
  snake[0].snakeBody.add(new PVector());
  snake[0].snakeBody.add(new PVector());;
  food[0].newFood();
}


void draw(){
  background(200);
  
  snake[0].update();
  
  stroke(0);
  strokeWeight(3);
  rect(snake[0].headLocation.x, snake[0].headLocation.y, snake[0].size, snake[0].size);
//  println(snake[0].headLocation);

  
  for (int i = snake[0].snakeBody.size() - 1; i > 0; i--){
    PVector current = (PVector)snake[0].snakeBody.get(i);
//    println(i, current);
//    println(" ", (PVector)snake[0].snakeBody.get(i));
//    println(i);
//    println("1:", (PVector)snake[0].snakeBody.get(0));
//    println("2:", (PVector)snake[0].snakeBody.get(1));
//    println("x:", snake[0].headLocation.x, "y:", snake[0].headLocation.y);
//    println("**");
    
    fill(color(100));
    stroke(255); 
    strokeWeight(1);
    
    rect(current.x, current.y, snake[0].size, snake[0].size);
    

    PVector next = (PVector) snake[0].snakeBody.get(i-1);
    current.x = next.x;
    current.y = next.y;
//    println("after of draw");
//    println("1:", (PVector)snake[0].snakeBody.get(0));
//    println("2:", (PVector)snake[0].snakeBody.get(1));
//    println("x:", snake[0].headLocation.x, "y:", snake[0].headLocation.y);
//    println("**");
//    println(" ", next);
//    println(" ", current);
    
  }
    
  println("------");
  
  if((abs(snake[0].headLocation.x - food[0].location.x) < food[0].r) && (abs(snake[0].headLocation.y - food[0].location.y) < food[0].r)){
    snake[0].snakeBody.add(new PVector(snake[0].headLocation.x, snake[0].headLocation.y));
    food[0].newFood();
  }else{
    fill(color(0,122,200));
    noStroke(); 
    rect(food[0].location.x, food[0].location.y, food[0].r, food[0].r); 
    stroke(255,255,255);
    strokeWeight(1);
    rect(food[0].location.x, food[0].location.y, food[0].r, food[0].r); 
  }
  
  if (snake[0].headLocation.x > width || snake[0].headLocation.x < 0 || snake[0].headLocation.y > height || snake[0].headLocation.y <0){
    noLoop();
    noFill();
    stroke(255);
    strokeWeight(3);
    rect(width/2, height/2, 200, 120);
    text("You Died!", width/2-30, height/2 -15 );
    rect(width/2, height/2+15, 70, 30);
    text("try again", width/2-25, height/2+18);
    noLoop();
  }
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
  if (mouseX >= width/2-35 && mouseX <= width/2 + 35 && mouseY>=height/2 && mouseY<=height/2+30){
    for (int i = snake[0].snakeBody.size()-1; i >= 0 ; i--){
     snake[0].snakeBody.remove(i);
    }
    println(snake[0].snakeBody.size());
    snake[0].headLocation = new PVector (width/2, height/2);
    snake[0].snakeBody.add(new PVector(snake[0].headLocation.x, snake[0].headLocation.y));
    snake[0].snakeBody.add(new PVector());
    snake[0].snakeBody.add(new PVector());
    snake[0].snakeBody.add(new PVector());
    snake[0].snakeBody.add(new PVector());
    food[0].newFood();
     
    loop();
  }
}

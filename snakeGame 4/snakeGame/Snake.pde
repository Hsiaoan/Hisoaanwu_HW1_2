class Snake{
  PVector headLocation;
  PVector velocity;
  ArrayList snakeBody;
  float size;

  Snake (float x, float y, float a, float b){
    headLocation = new PVector (x, y);
    velocity = new PVector (a, b);
    snakeBody = new ArrayList();
    size = 12.0;
  }
  
  void update(){
    headLocation = (PVector) snakeBody.get(0);
//    println("1:", (PVector)snake[0].snakeBody.get(0));
//    println("2:", (PVector)snake[0].snakeBody.get(1));
//    println("x:", snake[0].headLocation.x, "y:", snake[0].headLocation.y);
//    println("**");
    headLocation.add(velocity);
//    println("1:", (PVector)snake[0].snakeBody.get(0));
//    println("2:", (PVector)snake[0].snakeBody.get(1));
//    println("x:", snake[0].headLocation.x, "y:", snake[0].headLocation.y);
//    println("**");
        
//    if (headLocation.x > width){
//      headLocation.x -= width; 
//    }else if (headLocation.x < 0){
//      headLocation.x += width; 
//    }
//    
//    if (headLocation.y > height){
//      headLocation.y -= height; 
//    }else if(headLocation.y < 0){
//      headLocation.y += height; 
//    }
  }
}


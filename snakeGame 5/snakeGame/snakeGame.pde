Snake[] snake = new Snake[1];       //the snake
Food[] food = new Food[1];          //the food that the snake eats, appears on screen one at a time
Box[] box = new Box [3];            //the spaces where the snake hunts
Portal[] portal = new Portal [4];   //the portals that the snake uses to travel between spaces (boxes)
Note[] note = new Note [2];         //the note that displays when the snake dies
Portal[] grandPortal = new Portal [1];
Box[] pound = new Box [1];
Food[] waterFood = new Food[100];

boolean hitBox = false;             //turns "true" when the snake hits the border of the boxes
boolean hitPortal = false;          //turns "true" when the snake hits one of the portal
boolean foodOK = false;             //turns "true" if the location of the food (x, y) is in the boundry of the boxes
boolean messageDisplayed = false;   //turns "true" if a message is displayed
boolean oxygenFull = false;         //turns "true" when oxygen bar is full
boolean sceneSwitch = false;
PVector oxygenBox[] = new PVector[20]; //the oxygen bar which accumulates overtime
int oxygenCount = 0; //oxygen starts with 0
int secondCount = 0; //player gains 1 oxygen every 50 frames
int life = 5;
int eggCount = 0; //no use right now
int score = 0; 

PFont joystix;

//import processing.sound.*;
//SoundFile fail;
import ddf.minim.*;
Minim minim;
Minim coin;
Minim start;
AudioPlayer Player;

PImage egg;
PImage lake;

//make the game fullscreen
boolean sketchFullScreen() {
  return true;
}


/*----------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------*/



//setup the canvas
void setup() {
  size(1024, 768);
  smooth();

  //use this line of code to adjust the speed of the game  
  frameRate(18); 

  //load the font
  joystix = loadFont("Joystix-32.vlw");
  textFont(joystix);

  //get the music ready
  minim = new Minim(this);
  coin = new Minim(this);
  start = new Minim(this);

  //load the images
  egg = loadImage("msegg.png");
  lake = loadImage("lake.png");

  //prepare the waterFood for the pound
  for (int i = 0; i < waterFood.length; i++) {
    waterFood[i] = new Food (random(12, 732), random(12, 612), 10);
  }


  //creat a new snake head, the first food, the snake's body (which contains 5 
  snake[0] = new Snake (36, 36, 12, 0);
  food[0] = new Food (random(width), random(height), 10);
  snake[0].snakeBody.add(new PVector(snake[0].headLocation.x, snake[0].headLocation.y));
  for (int i=0; i<6; i++) { //change the number to change the length of the original snake
    snake[0].snakeBody.add(new PVector(snake[0].headLocation.x, snake[0].headLocation.y));
  }

  //setting up the snake's moving spaces
  box[0] = new Box (12, 12, 252, 252);
  box[1] = new Box (300, 12, 456, 300);
  box[2] = new Box (12, 360, 720, 252);
  pound[0] = new Box (12, 12, 732, 612);

  //setting up  the pairs of portals
  portal[0] = new Portal (264, 36, 12, 480, true, 60);
  portal[1] = new Portal (732, 408, 12, 204, true, 60);
  portal[2] = new Portal (348, 312, 636, 360, false, 60);
  portal[3] = new Portal (36, 264, 504, 12, false, 60);
  grandPortal[0] = new Portal (264, 612, 360, 12, false, 100);

  //make sure the egg is inside the boundry of the boxes
  while (foodOK == false) {
    food[0].newFood();
    for (int i = 0; i < box.length && foodOK == false; i++) {
      if ( food[0].location.x >= box[i].originPoint.x + 12 && food[0].location.x <= box[i].originPoint.x + box[i].size.x - 24
        && food[0].location.y >= box[i].originPoint.y + 12 && food[0].location.y <= box[i].originPoint.y + box[i].size.y - 24) {

        foodOK = true;
      } else {
        foodOK = false;
      }
    }
  }  

  //prepare the oxygen bar
  for (int i = 0; i < oxygenBox.length; i++) {
    oxygenBox[i] = new PVector(300+i*20, 60);
  }


  //setting up the note
  note[0] = new Note (width/2, height/2, 200, 120, 100, 30, "Your Snake Died!", "Try Again");//some more lives left
  note[1] = new Note (width/2, height/2, 200, 120, 100, 30, "Game Over!", "Exit Game");//no more life left
}

/*----------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------*/



void draw() {

  println("----------------new frame-------------------");
  background(0);

  //display life and score
  textMode(CENTER);
  textAlign(LEFT);
  fill(255);
  textSize(32);
  text("Life:", 60, 75);
  text(life, 180, 75);
  textAlign(RIGHT);
  text(nfs(score, 10), width - 60, 75);


  

  //draw the oxygen bar
  rectMode(CORNERS);
  strokeWeight(1);
  stroke(100, 178, 255);
  noFill();
  rect(300, 60, 700, 70);
  fill(100, 178, 255);
  noStroke();
  for (int i=0; i < oxygenCount; i++) {
    rect(oxygenBox[i].x, oxygenBox[i].y, oxygenBox[i].x+20, oxygenBox[i].y+10);
  }


  //a line that separates console and game area
  stroke(255);
  line (0, 90, 1024, 90);  

  pushMatrix();
  translate(120, 120);

  //the water scene
  if (sceneSwitch) {

    //draw the pound
    noStroke();
    fill(0, 0, 100);
    
    image(lake, pound[0].originPoint.x, pound[0].originPoint.y, pound[0].size.x, pound[0].size.y);
    
    //draw the grand portal
    strokeWeight(8);
    stroke(255);
    line(grandPortal[0].positionB.x, grandPortal[0].positionB.y, grandPortal[0].positionB.x + grandPortal[0].size, grandPortal[0].positionB.y);

    //update the status of the snake
    snake[0].update();

    //draw the snake's head
    stroke(0);
    strokeWeight(1);
    fill(224, 255, 255);
    rectMode(CORNER);
    rect(snake[0].headLocation.x, snake[0].headLocation.y, snake[0].size, snake[0].size);

    //draw the snake's body
    for (int i = snake[0].snakeBody.size () - 1; i > 0; i--) {
      PVector current = (PVector)snake[0].snakeBody.get(i);

      fill(color(224, 255, 255));
      stroke(0); 
      strokeWeight(1);
      rectMode(CORNER);
      rect(current.x, current.y, snake[0].size, snake[0].size); 

      PVector next = (PVector) snake[0].snakeBody.get(i-1);
      current.x = next.x;
      current.y = next.y;
    }

    //draw the water food
    for (int i = 0; i < waterFood.length; i++) {
      fill(color(255, 215, 0));
      noStroke(); 
      ellipseMode(CORNER); 
      ellipse(waterFood[i].location.x, waterFood[i].location.y, waterFood[i].r, waterFood[i].r * 1.2);
    }

    //when the snake eats the food
    for (int i = 0; i < waterFood.length; i++) {
      if ((abs(snake[0].headLocation.x - waterFood[i].location.x) < 1.5 * waterFood[i].r) && (abs(snake[0].headLocation.y - waterFood[i].location.y) < 1.5 * waterFood[i].r)) {

        score = score + 200;
        println("snake eats food");

        waterFood[i].location.x = -200;
        waterFood[i].location.y = -200;
        Player = coin.loadFile("coin.wav");
        Player.play();
      }
    }


    //check if snake runs into itself
    for (int i = snake[0].snakeBody.size ()-1; i > 1; i--) {
      if (snake[0].headLocation.dist((PVector) snake[0].snakeBody.get(i)) < food[0].r) {
        if (life == 0) {
          note[1].displayNote();
        } else {
          note[0].displayNote();
        }

        messageDisplayed = true;
      }
    }


    //check edges if snake hits the wall of the boxes
    if ( abs(snake[0].headLocation.x - pound[0].originPoint.x) == 0 || abs(snake[0].headLocation.x - (pound[0].originPoint.x + pound[0].size.x)) ==12 ) {
      if (snake[0].headLocation.y >= pound[0].originPoint.y && snake[0].headLocation.y <= pound[0].originPoint.y + pound[0].size.y) {
        hitBox = true;
      }
    } else if (abs(snake[0].headLocation.y - pound[0].originPoint.y) == 0 || abs(snake[0].headLocation.y - (pound[0].originPoint.y + pound[0].size.y)) == 12) {
      if (snake[0].headLocation.x >= pound[0].originPoint.x && snake[0].headLocation.x <= pound[0].originPoint.x + pound[0].size.x) {
        hitBox = true;
      }
    }



    if (hitBox) {
      if (abs(snake[0].headLocation.y - grandPortal[0].positionB.y) == 0 && snake[0].headLocation.x >= grandPortal[0].positionB.x && snake[0].headLocation.x <= grandPortal[0].positionB.x + grandPortal[0].size) {

        hitPortal = true;
        hitBox = false;

        snake[0].headLocation.y = grandPortal[0].positionA.y - 12;
        snake[0].headLocation.x = grandPortal[0].positionA.x + (snake[0].headLocation.x - grandPortal[0].positionB.x);
        sceneSwitch = false;
        Player = start.loadFile("pipe.wav");
        Player.play();  
      } else {
        if (life == 0) {
          note[1].displayNote();
        } else {
          note[0].displayNote();
        }

        messageDisplayed = true;
      }
    }

    //the oxygen graduadlly goes down
    
    if (secondCount < 10) {
      secondCount ++;
    } else if (secondCount == 10 && oxygenCount > 0) {
      secondCount =0;
      oxygenCount--;
      oxygenFull = false;
    }

    if (oxygenCount == 0) {
      if (life == 0) {
        note[1].displayNote();
      } else {
        note[0].displayNote();
      }

      messageDisplayed = true;
    }

    popMatrix();


  /*----------------------------------------------------------------------------------------------------------*/
  /*--------------------------------------the end for the pound-----------------------------------------------*/
  /*----------------------------------------------------------------------------------------------------------*/
  

  //the portal scene
  } else {

    //update the status of the snake
    snake[0].update();
    println("snake moves forward one step");

    //draw the snake's head
    stroke(0);
    strokeWeight(1);
    fill(224, 255, 255);
    rectMode(CORNER);
    rect(snake[0].headLocation.x, snake[0].headLocation.y, snake[0].size, snake[0].size);

    //draw the snake's body
    for (int i = snake[0].snakeBody.size () - 1; i > 0; i--) {
      PVector current = (PVector)snake[0].snakeBody.get(i);

      fill(224, 255, 255);
      stroke(0); 
      strokeWeight(1);
      rectMode(CORNER);
      rect(current.x, current.y, snake[0].size, snake[0].size); 

      PVector next = (PVector) snake[0].snakeBody.get(i-1);
      current.x = next.x;
      current.y = next.y;
    }

    
    //draw the boxes
    stroke(255);
    strokeWeight(3);
    noFill();
    rectMode(CORNER);
    for (int i = 0; i < box.length; i++) {
      rect(box[i].originPoint.x, box[i].originPoint.y, box[i].size.x, box[i].size.y);
    }


    //draw the portals
    for (int i = 0; i < portal.length; i++) {
      //set the portal colors
      if (i==0) {
        stroke(255, 20, 147);
      } else if (i == 1) {
        stroke(255, 215, 0);
      } else if (i == 2) {
        stroke(255, 99, 71);
      } else if (i == 3) {
        stroke(50, 205, 50);
      }

      strokeWeight(8);


      //vertical portals
      if (portal[i].type) {
        line(portal[i].positionA.x, portal[i].positionA.y, portal[i].positionA.x, portal[i].positionA.y + portal[i].size);
        line(portal[i].positionB.x, portal[i].positionB.y, portal[i].positionB.x, portal[i].positionB.y + portal[i].size);

        //horizontal portals
      } else if (!portal[i].type) {
        line(portal[i].positionA.x, portal[i].positionA.y, portal[i].positionA.x + portal[i].size, portal[i].positionA.y);
        line(portal[i].positionB.x, portal[i].positionB.y, portal[i].positionB.x + portal[i].size, portal[i].positionB.y);
      }
    }

    //show the grandPortal when the oxygen bar is full
    if (oxygenFull) {
      strokeWeight(8);
      stroke(255);
      line(grandPortal[0].positionA.x, grandPortal[0].positionA.y, grandPortal[0].positionA.x+ grandPortal[0].size, grandPortal[0].positionA.y);
    }
    
    
    //check if snake runs into itself
    for (int i = snake[0].snakeBody.size ()-1; i > 1; i--) {
      if (snake[0].headLocation.dist((PVector) snake[0].snakeBody.get(i)) < 6) {
        println("snake runs into itself");
        if (life == 0) {
          note[1].displayNote();
        } else {
          note[0].displayNote();
        }

        messageDisplayed = true;
      }
    }

    //snake eats the food (it is very important that this part goes after checking if the snake runs into itself)
    if ((abs(snake[0].headLocation.x - food[0].location.x) < 1.5 * food[0].r) && (abs(snake[0].headLocation.y - food[0].location.y) < 1.5 * food[0].r)) {
      snake[0].snakeBody.add(new PVector(snake[0].headLocation.x, snake[0].headLocation.y));
      foodOK = false;
      score = score + 100;
      if (oxygenCount <20) {
      oxygenCount++;
      oxygenCount++;//delete this and the rest below to have a normal game experience
      oxygenCount++;
      oxygenCount++;
      oxygenCount++;
      Player = coin.loadFile("coin.wav");
      Player.play();
      }
      println("snake eats food");

      //again, make sure the egg is in the boundry of the boxes
      while (foodOK == false) {
        food[0].newFood();
        for (int i = 0; i < box.length && foodOK == false; i++) {
          if ( food[0].location.x >= box[i].originPoint.x +12 && food[0].location.x <= box[i].originPoint.x + box[i].size.x - 24
            && food[0].location.y >= box[i].originPoint.y +12 && food[0].location.y <= box[i].originPoint.y + box[i].size.y - 24) {
            foodOK = true;
          } else {
            foodOK = false;
          }
        }
      }
      //if it doesn't eat the egg, just keep going
    } else {
      fill(color(255));
      noStroke(); 
      ellipseMode(CORNER); 
      ellipse(food[0].location.x, food[0].location.y, food[0].r, food[0].r * 1.2); 
      //      image(egg, food[0].location.x, food[0].location.y, 12, 12);
      foodOK = false;
    }



    //check edges if snake hits the wall of the boxes
    for (int i = 0; i < box.length; i++) {
      println("checking if the snake runs into box", i);
      if ( abs(snake[0].headLocation.x - box[i].originPoint.x) == 0 || abs(snake[0].headLocation.x - (box[i].originPoint.x + box[i].size.x)) == 12 ) {

        if (snake[0].headLocation.y >= box[i].originPoint.y && snake[0].headLocation.y <= box[i].originPoint.y + box[i].size.y) {
          println("snake hits the left/right side of box", i);
          hitBox = true;
        }
      } else if (abs(snake[0].headLocation.y - box[i].originPoint.y) == 0 || abs(snake[0].headLocation.y - (box[i].originPoint.y + box[i].size.y)) == 12) {
        if (snake[0].headLocation.x >= box[i].originPoint.x && snake[0].headLocation.x <= box[i].originPoint.x + box[i].size.x) {
          println("snake hits the top/bottom side of box", i);
          hitBox = true;
        }
      }
    }



    //check if the snake hits a portal
    if (hitBox) {

      println("determinning if the snake runs into a portal");
      println(snake[0].headLocation.x, snake[0].headLocation.y);
      for (int i=2; i < 4; i++) {
        println("for reference, the distance between the snake's head and the portal", i, "is", abs(snake[0].headLocation.y - portal[i].positionA.y), "this is portal", i, "'s A side");
        println("for reference, the distance between the snake's head and the portal", i, "is", abs(snake[0].headLocation.y - portal[i].positionB.y), "this is portal", i, "'s B side");
      }


      for (int j = 0; j < portal.length; j++) {
        println("checking portal", j, "..........");

        if (portal[j].type) {
          //if the snake hits the portal from left to right
          if (abs(snake[0].headLocation.x - portal[j].positionA.x) == 12) {
            println("mistake");

            //check if the Y axis of the snake's head is in the boundry of the portal
            if ( snake[0].headLocation.y >= portal[j].positionA.y && snake[0].headLocation.y <= portal[j].positionA.y + portal[j].size) {

              hitPortal = true;
              hitBox = false;

              if (snake[0].velocity.x > 0) {
                //snake goes through the portal
                snake[0].headLocation.x = portal[j].positionB.x - 12;
                snake[0].headLocation.y = portal[j].positionB.y + (snake[0].headLocation.y - portal[j].positionA.y);
              }
            }
          //if the snake hits the portal from right to left
          } else if (abs(snake[0].headLocation.x - portal[j].positionB.x) == 0) {
            println("mistake");


            //check if the Y axis of the snake's head is in the boundry of the portal
            if ( snake[0].headLocation.y >= portal[j].positionB.y && snake[0].headLocation.y <= portal[j].positionB.y + portal[j].size) {

              hitPortal = true;
              hitBox = false;

              if (snake[0].velocity.x < 0) {
                //snake goes through the portal
                snake[0].headLocation.x = portal[j].positionA.x ;
                snake[0].headLocation.y = portal[j].positionA.y + (snake[0].headLocation.y - portal[j].positionB.y);
              }
            }
          }
        } else {

          //if the snake hits the portal from top to bottom
          if (abs(snake[0].headLocation.y - portal[j].positionA.y) == 12) {
            println("snake comming from the top of portal", j);



            //check if the X axis of the snake's head is in the boundry of the portal
            if ( snake[0].headLocation.x >= portal[j].positionA.x && snake[0].headLocation.x <= portal[j].positionA.x + portal[j].size) {
              println("portal", j, "hit");
              hitPortal = true;
              hitBox = false;

              if (snake[0].velocity.y > 0) {
                println("and the snake goes through portal", j);
                //snake goes through portal
                snake[0].headLocation.y = portal[j].positionB.y - 12;
                snake[0].headLocation.x = portal[j].positionB.x + (snake[0].headLocation.x - portal[j].positionA.x);
              }
            }

            //if the snake hits the portal from bottom to top
          } else if (abs(snake[0].headLocation.y - portal[j].positionB.y) == 0) {
            println("snake comming from the bottom of portal", j);
            //check if the X axis of the snake's head is in the boundry of the portal
            if ( snake[0].headLocation.x >= portal[j].positionB.x && snake[0].headLocation.x <= portal[j].positionB.x + portal[j].size) {
              println("portal", j, "hit");
              hitPortal = true;
              hitBox = false;

              if (snake[0].velocity.y <0) {
                println("and the snake goes through portal", j); 
                //snake goes through portal
                snake[0].headLocation.y = portal[j].positionA.y;
                snake[0].headLocation.x = portal[j].positionA.x + (snake[0].headLocation.x - portal[j].positionB.x);
              }
            }
          }
        }
      }
    }
    println(hitBox, hitPortal);
    if (oxygenCount == 20) {
      oxygenFull = true;
    }else{
      oxygenFull = false;
    }

    if (hitBox && oxygenFull && !sceneSwitch && abs(snake[0].headLocation.y - grandPortal[0].positionA.y) == 12 && snake[0].headLocation.x >= grandPortal[0].positionA.x && snake[0].headLocation.x <= grandPortal[0].positionA.x + grandPortal[0].size) {

      hitPortal = true;
      hitBox = false;

      snake[0].headLocation.y = grandPortal[0].positionB.y;
      snake[0].headLocation.x = grandPortal[0].positionB.x + (snake[0].headLocation.x - grandPortal[0].positionA.x);
      sceneSwitch = true;
      Player = start.loadFile("pipe.wav");
      Player.play();  
      for (int i = 0; i < waterFood.length; i++) {
        waterFood[i].newWaterFood();
      }
    } 

    if (hitBox && !hitPortal) {
      println("**********************the snake dies***********************");
      if (life == 0) {
        note[1].displayNote();
      } else {
        note[0].displayNote();
      }

      messageDisplayed = true;
    }
    
    hitPortal = false;






    popMatrix();

    textMode(CENTER);
    textAlign(LEFT);
    fill(255, 255, 0);
    textSize(12);
//    text(mouseX, mouseX+10, mouseY);
//    text(mouseY, mouseX+10, mouseY+10);




  }



  score++;
}

void keyPressed() { 
  if (key == CODED) { 
    if (snake[0].velocity.x == 0) { 
      if (keyCode == LEFT) {
        snake[0].velocity = new PVector(-abs(snake[0].velocity.y), 0);
      } else if (keyCode == RIGHT) {
        snake[0].velocity = new PVector(abs(snake[0].velocity.y), 0);
      }
    }

    if (snake[0].velocity.y == 0) { 
      if (keyCode == UP) {
        snake[0].velocity = new PVector(0, -abs(snake[0].velocity.x));
      } else if (keyCode == DOWN) {
        snake[0].velocity = new PVector(0, abs(snake[0].velocity.x));
      }
    }
  }
}

void mouseClicked() {
  if (mouseX >= width/2-35 
    && mouseX <= width/2 + 35 && mouseY>=height/2 
    && mouseY<=height/2+30 
    && messageDisplayed == true) {
    if (life ==0 ) {
      exit();
    }

    for (int i = snake[0].snakeBody.size ()-1; i >= 0; i--) {
      snake[0].snakeBody.remove(i);
    }

    snake[0].headLocation = new PVector (36, 36);
    snake[0].velocity = new PVector (12, 0);
    snake[0].snakeBody.add(new PVector(snake[0].headLocation.x, snake[0].headLocation.y));

    for (int i=0; i<10; i++) {
      snake[0].snakeBody.add(new PVector());
    }



    foodOK = false;
    while (foodOK == false) {
      food[0].newFood();
      for (int i = 0; i < box.length && foodOK == false; i++) {
        if ( food[0].location.x >= box[i].originPoint.x && food[0].location.x <= box[i].originPoint.x + box[i].size.x
          && food[0].location.y >= box[i].originPoint.y && food[0].location.y <= box[i].originPoint.y + box[i].size.y) {

          foodOK = true;
        } else {
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

    sceneSwitch = false;
    oxygenFull = false;

    //lose one life
    life --;

    println("-----------------------------Game started again------------------------------");
  }
}


// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover[] movers = new Mover[5];

void setup() {
  size(383, 200);
  randomSeed(5);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(1,8), random(width), 0);
  }
}

void draw() {
  background(255);

  for (int i = 0; i < movers.length; i++) {

    PVector wind = new PVector(-0.001, 0);
    PVector gravity = new PVector(0, 0.1*movers[i].mass);

    float c = 0.05;
    PVector friction = movers[i].velocity.get();
    friction.mult(-1); 
    friction.normalize();
    friction.mult(c);

    movers[i].applyForce(friction);
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);

    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}

 void mouseClicked() {
   for (int i = 0; i < movers.length; i++) {  
   if (sq(mouseX-movers[i].location.x)+sq(mouseY-movers[i].location.y)< sq(movers[i].mass*8)){
     
       movers[i].location.y = height-movers[i].mass*8;
       movers[i].velocity.y = 0;
    }
 }
 }

 
 










/**

**/
float radius = 360.0;
float angle = 0.0;
float x,y;
int s = second();  // Values from 0 - 59
int m = minute();  // Values from 0 - 59
int h = hour();    // Values from 0 - 23

void setup(){
  size(800,800);
}

void draw(){
  background(25);
  translate(width/2, height/2);//display the clocck
  ellipseMode(CENTER);
  fill(230,180,110);
  noStroke();
  ellipse(0,0,750, 750);
  ellipse(0,0,5,5);
  strokeWeight(15); 
  
   
  
 for (int i=0; i<12;i++){ //for the scale indication
 float angle=TWO_PI/12*i;
 strokeWeight(20);
 stroke(60,180,60);
 line(330*cos(angle), 330*sin(angle), 359*cos(angle), 359*sin(angle));//make the scale indication distribute evenly on the clock
 }

  angle = (minute() / 59.0) * TWO_PI;// make the indicator move by minute
  stroke(24,130,180);
  line(0,0,second()*6*cos(angle),second()*6*sin(angle));//make the indicator grow by second
  
  
 

  ellipse(x,y,0,0);
  
}
  
  


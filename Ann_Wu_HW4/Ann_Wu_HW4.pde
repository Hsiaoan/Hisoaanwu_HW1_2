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
  fill(128,128,128);
  noStroke();
  ellipse(0,0,750, 750);
  ellipse(0,0,5,5);
  rotate(PI+HALF_PI);//adjust the clock direction)
  
   
  
 for (int i=0; i<12;i++){ //for the scale indication
 float angle=TWO_PI/12*i;
 strokeWeight(30);
 stroke(102,255,178);
 line(330*cos(angle), 330*sin(angle), 359*cos(angle), 359*sin(angle));//make the scale indication distribute evenly on the clock
 }

  float angleM = (minute() / 59.0) * TWO_PI;// make the indicator move by minute
  stroke(255,255,153);
  strokeWeight(40);
  line(0,0,second()*6*cos(angleM),second()*6*sin(angleM));//make the indicator grow by second
  ellipse(x,y,0,0);
  
  float angleH = (hour() / 12.0) * TWO_PI;
  stroke(255,65,116);
  strokeWeight(40);
  line(0,0,100*cos(angleH),100*sin(angleH)); // make the indicator move by hour
}
  
  


function setup(){
  createCanvas(900, 400);
  var x1, y1, x2, y2; // 2 points and i
}
function draw(){
 for (var i=0; i<50; i++) {//i as for condition to execute it
   x1=random(0,900);// the range
   y1=random(0,400);
   x2=random(0,900);
   y2=random(0,400);
   noFill();
   beginShape();
   vertex(x1,y1);
   vertex(x2,y1);
   vertex(x2,y1);
   vertex(x1,y2);
   endShape(CLOSE);
   x1=x2; // means continue and replace
   y1=y2;
 }
}



  
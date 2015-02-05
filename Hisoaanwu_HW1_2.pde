float x0,y0,x1,y1,r;

void setup(){
  size(800,400);
  noFill();
x0=random(600,800);
x1=random(0,800);
y0=-2*x0+1600;
y1=0.5*x1-2.5*x0+1600;
for(float a=y1; a<0||a>400;a=y1){
  x1=random(0,800);
  y1=0.5*x1-2.5*x0+1600;
}
line(800,0,600,400);
if(y0>200){
r=random(abs(2*x1+y1-1600)/sqrt(5),sqrt(sq(x1-600)+sq(0.5*x1-2.5*x0+1200)));
}else{
r=random(abs(2*x1+y1-1600)/sqrt(5),sqrt(sq(x1-800)+sq(0.5*x1-2.5*x0+1600)));
arc(x1,y1,2*r,2*r,0,TWO_PI);
point(x0,y0);
point(x1,y1);
}
}

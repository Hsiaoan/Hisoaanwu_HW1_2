class Food{
  PVector location;
  float r;
  
  Food (float locationX, float locationY, float radius){
    location = new PVector (locationX, locationY);
    r = radius;
  }
  
  void newFood(){
    location = new PVector (random(width), random(height));
  }
}



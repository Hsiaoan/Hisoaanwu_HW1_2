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
  
  void newWaterFood(){
    location = new PVector (random(12, 732), random(12, 612));  
  }
    
}



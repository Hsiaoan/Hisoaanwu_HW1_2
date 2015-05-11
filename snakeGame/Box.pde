class Box {
  PVector originPoint;
  PVector size;
  
  Box (float x, float y, float a, float b) {
    originPoint = new PVector(x, y);
    size = new PVector(a, b);
  }
  
}

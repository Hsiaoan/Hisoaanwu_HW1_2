class Portal {
  PVector positionA;
  PVector positionB;
  int id;
  boolean type;
  float size;
  
  Portal (float x1, float y1, float x2, float y2, int n, boolean direction, float s) {
    positionA = new PVector (x1, y1);
    positionB = new PVector (x2, y2);
    id = n;
    type = direction;
    size = s;
  }
  
} 

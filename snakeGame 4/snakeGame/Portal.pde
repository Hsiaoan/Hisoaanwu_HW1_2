class Portal {
  PVector positionA;//the portals come in pairs, therefore there are one location for each in the pair
  PVector positionB;//the location for the second item in the pair
  boolean type;//ture means it's a vertical portal, and false means it's a horizontal portal
  float size;//both portal share the same size
  
  Portal (float x1, float y1, float x2, float y2, boolean direction, float s) {
    positionA = new PVector (x1, y1);
    positionB = new PVector (x2, y2);
    type = direction;
    size = s;
  }
  
} 

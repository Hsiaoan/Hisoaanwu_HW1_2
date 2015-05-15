//class Level {
//  int numBoxes;
//  ArrayList <Box> boxes;
//  
//  int numPortals;
//  
//  A
////  int difficulty;
//  float [] boxX =  new float [6];
//  float [] boxY =  new float [6];
//  float [] boxWidth =  new float [6];
//  float [] boxHeight =  new float [6];  
//  float [] portalX1 =  new float [6];
//  float [] portalY1 =  new float [6];
//  float [] portalX2 =  new float [6];
//  float [] portalY2 =  new float [6];
//  boolean [] portalType  = new boolean [6];
//  float [] portalSize = new float [6];
//  Box [] box = new
//  ArrayList <Box> boxes;
//  
//  Level (int m, int n, int d, 
//    float bx1, float by1, float bw1, float bh1, 
//    float bx2, float by2, float bw2, float bh2, 
//    float bx3, float by3, float bw3, float bh3, 
//    float bx4, float by4, float bw4, float bh4, 
//    float bx5, float by5, float bw5, float bh5, 
//    float paX1, float paY1, float pbX1, float pbY1, boolean d1, float s1,
//    float paX2, float paY2, float pbX2, float pbY2, boolean d2, float s2,
//    float paX3, float paY3, float pbX3, float pbY3, boolean d3, float s3,
//    float paX4, float paY4, float pbX4, float pbY4, boolean d4, float s4,
//    float paX5, float paY5, float pbX5, float pbY5, boolean d5, float s5 ) {
//    
//    
//      
//    this.boxes = new ArrayList <Box> ();
//    boxes.add(new Box(bx1, by1));
//      numBoxes = m ;
//    numPortals = n ;
//    difficulty = d ;
//    
//    boxX[0] = 12;
//    boxY[0] = 12;
//    boxWidth[0] = 885;
//    boxHeight[0] = 629;
//    portalX1[0] = 0;
//    portalY1[0] = 0;
//    portalX2[0] = 0;
//    portalY2[0] = 0;
//    portalType[0] = false;
//    portalSize[0] = 16;
//    
//    
//    
//    boxX[1] = bx1;
//    boxY[1] = by1;
//    boxWidth[1] = bw1;
//    boxHeight[1] = bh1;
//    portalX1[1] = paX1;
//    portalY1[1] = paY1;
//    portalX2[1] = pbX1;
//    portalY2[1] = pbY1;
//    portalType[1] = d1;
//    portalSize[1] = s1;
//    
//    boxX[2] = bx2;
//    boxY[2] = by2;
//    boxWidth[2] = bw2;
//    boxHeight[2] = bh2;
//    portalX1[2] = paX2;
//    portalY1[2] = paY2;
//    portalX2[2] = pbX2;
//    portalY2[2] = pbY2;
//    portalType[2] = d2;
//    portalSize[2] = s2;    
//    
//    boxX[3] = bx3;
//    boxY[3] = by3;
//    boxWidth[3] = bw3;
//    boxHeight[3] = bh3;
//    portalX1[3] = paX3;
//    portalY1[3] = paY3;
//    portalX2[3] = pbX3;
//    portalY2[3] = pbY3;
//    portalType[3] = d3;
//    portalSize[3] = s3;    
//    
//    boxX[4] = bx4;
//    boxY[4] = by4;
//    boxWidth[4] = bw4;
//    boxHeight[4] = bh4;
//    portalX1[4] = paX4;
//    portalY1[4] = paY4;
//    portalX2[4] = pbX4;
//    portalY2[4] = pbY4;
//    portalType[4] = d4;
//    portalSize[4] = s4;    
//    
//    boxX[5] = bx5;
//    boxY[5] = by5;
//    boxWidth[5] = bw5;
//    boxHeight[5] = bh5;
//    portalX1[5] = paX5;
//    portalY1[5] = paY5;
//    portalX2[5] = pbX5;
//    portalY2[5] = pbY5;
//    portalType[5] = d5;
//    portalSize[5] = s5;    
//  }
//  
//  void setup{
//    
//    //draw the boxes
//    stroke(0);
//    strokeWeight(3);
//    noFill();
//    rectMode(CORNER);
//    for (i=1; i < numBoxes; i++) {
//      rect(boxX[i], boxY[i], boxWidth[i], boxHeight[i]);
//    }
//    
//    //draw portals
//    for (int i = 1; i < numPortals; i++) {
//      //set the portal colors
//      if (i==0){
//        stroke(255,225,0);
//      }else if (i == 1) {
//        stroke(255, 0, 255);
//      }else if (i == 2) {
//        stroke(0, 255, 255);
//      }else if (i == 3) {
//        stroke(0, 200, 0);
//      }
//      
//      strokeWeight(5);
//      
//      //vertical portals
//      if (portal[i].type){
//        line(portalX1[i], portalY1[i], portalX1[i], portalY1[i]+ portalSize[i]);
//        line(portalX2[i], portalY2[i], portalX2[i], portalY2[i]+ portalSize[i]);
//      
//      //horizontal portals  
//      }else if (!portal[i].type){
//        line(portalX1[i], portalY1[i], portalX1[i] + portalSize[i], portalY1[i]);
//        line(portalX2[i], portalY2[i], portalX2[i] + portalSize[i], portalY2[i]);  
//      }  
//    }
//    
//  }
//  
//  void 
//  
//    
//  


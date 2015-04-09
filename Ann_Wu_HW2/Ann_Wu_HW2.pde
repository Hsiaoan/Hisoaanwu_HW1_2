/*
** Cyclist Count by Year At Selected Commuter Locations
** data from:
** https://data.cityofnewyork.us/d/m6ar-24vj?category=Transportation&view_name=Cyclist-Count-by-Year-At-Selected-Commuter-Locatio
** Basic idea: To make the rows present various year, and the columns as difference place. 
   In addition, The length of the colorful line represent the amount of cyclists.
*/

String[] headers;
int[][] data; 

void setup(){
  String [] lines = loadStrings("Cyclist_Count_by_Year_At_Selected_Commuter_Locations.csv");
  // load csv file into String array
  size(1900,1900);
  background(10);
  
  headers = split(lines[0], ",");
  println(headers[0]);
  String[][] tempData = new String[lines.length-1][headers.length];
  
  for(int i = 1; i < lines.length; i++){
    tempData[i-1] = split(lines[i], ",");
    //call the Data and assigns an array to each temData row
  }
  
  data = new int[tempData.length][tempData[0].length];
  

  for(int i = 0; i < tempData.length; i++){ //for each row
    for(int j = 0; j < tempData[i].length; j++){ //and for each col
      
      String[] tempCellValue = split(tempData[i][j], "\"");
      // our middle entry contains the data, so we write tempCellValue[1]
      // handle our blank data OR data containing "N/A" by replacing with 0s 
      
      if(tempCellValue[1].equals("") || tempCellValue[1].equals("N/A")){
        data[i][j] = 0;
      }
      else {
        data[i][j] = Integer.parseInt(tempCellValue[1]);
      }
    }
  }
 
 frameRate(0.5);
     
}
void draw(){
    background(0);
  
  for(int i=0;i<data.length;i++){ 
    for(int j=0;j<data[i].length;j++){
     float a=random(20,255);
     float b=random(20,255);
     float c=random(20,255);
     stroke(a, b, c); //set random color
     strokeWeight(20);
     
     textSize(20);
     fill(255);
     text(str(data[i][0]),0*100+50+data[i][0]/200+20, i*20+60);// adjsut the position of text
     textSize(10);
     text(headers[j],j*100+50+data[0][j]/200, 0*20+20);
     line(j*100+150,i*20+50,j*100+150+data[i][j]/100,i*20+50); 
     //make the line presentign the amount of cyclists at the appropriate place
           
         }
     
      }
  
  }
   


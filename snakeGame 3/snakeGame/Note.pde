class Note {
  PVector location;
  PVector size;
  PVector buttonSize;
  String message;
  String button;
  
  Note (float x, float y, float a, float b, float m, float n, String p, String q) {
    location = new PVector (x, y);
    size = new PVector (a, b);
    buttonSize = new PVector (m, n);
    message = p;
    button = q;
  }
  
  void displayNote() {
    popMatrix(); //make sure the note is not being pushed
    fill(100);
    stroke(255);
    strokeWeight(3);
    rectMode(CENTER);
    rect(location.x, location.y, size.x, size.y); 
    rect(location.x, location.y+15, buttonSize.x, buttonSize.y);

    textMode(CENTER);
    textAlign(LEFT);
    fill(255, 255, 0);
    textSize(12);
    text(message, location.x-45, location.y -15);
    text(button, location.x-25, location.y+18);
    noLoop();
    pushMatrix(); //end of drawing note, start pushing again

  }
}

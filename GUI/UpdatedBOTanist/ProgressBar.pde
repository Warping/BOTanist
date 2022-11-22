class ProgressBar extends PageElement {
  
  int len;
  int yoff;
  float status;  
  
  ProgressBar(int xpos, int ypos, int _len, int _yoff, float _status) {
    super(xpos, ypos);
    status = constrain(_status, 0, 1);
    len = _len;
    yoff = _yoff; 
  }
  
  void render() {
    pushMatrix();
    noStroke();
    float barLength = map(status, 0, 1, 0, len);
    color statusColor = color(0,0,0);                    
    if (status < 1.0 && status >= 0.75) statusColor = color(0, 255, 0);
    if (status < 0.75 && status >= 0.5) statusColor = color(255, 255, 0);
    if (status < 0.5 && status >= 0.25) statusColor = color(255, 165, 0);
    if (status < 0.25) statusColor = color(255, 0, 0);
    fill(statusColor);
    rectMode(CORNER);
    rect(pos.x - len/2, pos.y - yoff/2, barLength, yoff);
    rectMode(CENTER);
    noFill();
    strokeWeight(1);
    stroke(statusColor);
    rect(pos.x, pos.y, len, yoff);
    popMatrix();
  }
  
  void update(float newStatus) {
    status = newStatus;
  }
  
  float getStatus() {
    return status;
  }
  
  void setStatus(float _status) {
    status = _status;
  }
}

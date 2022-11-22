class PieChart extends PageElement {

  float radius;
  float status;
  
  PieChart(int xpos, int ypos, int _radius, float _status) {
    super(xpos, ypos);
    radius = _radius;
    status = _status;
  }
  
  void render() {
    pushMatrix();
    float arcLength = map(status, 0, 1, 0, 2*PI);
    noStroke();
    color statusColor = color(0,0,0);                    
    if (status < 1.0 && status >= 0.75) statusColor = color(0, 255, 0);
    if (status < 0.75 && status >= 0.5) statusColor = color(255, 255, 0);
    if (status < 0.5 && status >= 0.25) statusColor = color(255, 165, 0);
    if (status < 0.25) statusColor = color(255, 0, 0);
    fill(statusColor);
    arc(pos.x, pos.y, radius*2, radius*2, 0, arcLength, PIE);
    noFill();
    stroke(statusColor);
    strokeWeight(1);
    ellipse(pos.x, pos.y, radius*2, radius*2);
    popMatrix();
  }
  
  void update(float newStatus) {
    status = newStatus % 1;
  }
}

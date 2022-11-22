class Button extends PageElement {
  
  PVector size;
  color rectColor, rectHighlight, textColor;
  String text;
  int page;
  
  Button(int xpos, int ypos, int xsize, int ysize, color _rectColor, color highlight, color _textColor, String _text, int _page) {
    super(xpos, ypos);
    size = new PVector(xsize, ysize);
    rectColor = _rectColor;
    rectHighlight = highlight;
    text = _text;
    textColor = _textColor;
    page = _page;
  }
  
  Button(int xsize, int ysize, color _rectColor, color highlight, color _textColor, String _text, int _page) {
    super(0, 0);
    size = new PVector(xsize, ysize);
    rectColor = _rectColor;
    rectHighlight = highlight;
    text = _text;
    textColor = _textColor;
    page = _page;
  }
  
  void render() {
    pushMatrix();
    rectMode(CENTER);
    fill((rectOver()) ? rectHighlight : rectColor);
    noStroke();
    rect(super.pos.x, super.pos.y, size.x, size.y);
    fill(textColor);
    textAlign(CENTER, CENTER);
    textSize(2* size.x / text.length());
    text(text, super.pos.x, super.pos.y - size.y/8);
    popMatrix();
  }
  
  void update(){ 
    rectOver();
  }
  
  void setText(String _text) {
    text = _text;
  }
  
  int getButtonPage() {
    return page;
  }

  boolean rectOver(){
    if (mouseX >= super.pos.x - size.x/2 && 
        mouseX <= super.pos.x + size.x/2 && 
        mouseY >= super.pos.y - size.y/2 && 
        mouseY <= super.pos.y + size.y/2
        ) return true;
    return false;
  }
  
  boolean isPressed() {
    return (rectOver() && mousePressed);
  }
}

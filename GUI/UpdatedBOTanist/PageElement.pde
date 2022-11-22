abstract class PageElement {
  
  PVector pos;

  PageElement(int xpos, int ypos) {
    pos = new PVector(xpos, ypos);
  }
  
  void render() {}
  void update() {}
  
  PVector getPosFromIndex(int row, int col, int xoff, int yoff, int xsize, int ysize) {
    return new PVector(xoff + width/xsize*col, yoff + height/ysize*row);
  }
  
  void setPos(PVector _pos) {
    pos = _pos.copy();
  }
}

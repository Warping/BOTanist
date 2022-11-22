static final int HPAGE = 0;

class HomePanel extends Panel {
  Button addGarden, test1;
  Garden garden;
  HomePanel(Garden _garden) {
    super();
    garden = _garden;
    //garden2 = _garden2;
    //Button(int xsize, int ysize, color _rectColor, color highlight, color _textColor, String _text)
    //getPosFromIndex(int row, int col, int xoff, int yoff, int xsize, int ysize)
    
    test1 = new Button(300, 100, color(104, 160, 215), color(75, 117, 159), color(0), garden.getGardenName(), HPAGE);
    test1.setPos(test1.getPosFromIndex(0, 1, (int) test1.size.x/10 - 40, 2*(int) test1.size.y*2 + 100, 3, 4));
    addElement(test1);
    
    addGarden = new Button(100, 100, color(104, 160, 215), color(75, 117, 159), color(0), "+", HPAGE);
    addGarden.setPos(addGarden.getPosFromIndex(1, 2, (int) addGarden.size.x/10 - 40, 2*(int) addGarden.size.y*2 + 100, 3, 4));
    addElement(addGarden);
  }
  
  void render() {
    int index = 0;
    printText();
    for (PageElement p : this.getElements()) {
      if (p instanceof Button) {
        garden.plants.get(index).updatePlant();
        ((Button) p).update();
        index++;
      }      
      p.update();
      p.render();
    }
    
    if(test1.isPressed()) {
      PAGE = 1;
    }
  }
  
  void printText() {
    textSize(40);
    text("HOME", 500, 100);
    rectMode(CENTER);
    fill(0);
  }
  
  int getPanelPage() {
    return GPAGE; 
  }
}

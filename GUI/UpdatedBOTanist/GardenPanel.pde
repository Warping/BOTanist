static final int GPAGE = 1;

class GardenPanel extends Panel {
  Garden garden;
  Button backButton, plant1, plant2, plant3;
  
  //Creates new Garden Panel showing plant info / health
  GardenPanel(Garden _garden) {
    super();
    garden = _garden;
    //getPosFromIndex(int row, int col, int xoff, int yoff, int xsize, int ysize)
    
    plant1 = new Button(150, 50, color(104, 160, 215), color(75, 117, 159), color(0), garden.getPlants().get(0).getPlantName(), GPAGE); 
    plant1.setPos(plant1.getPosFromIndex(0, 0, (int) plant1.size.x/2 + 25, (int) plant1.size.y*4 + 25, 3, 4));
    addElement(plant1);
    
    plant2 = new Button(150, 50, color(104, 160, 215), color(75, 117, 159), color(0), garden.getPlants().get(1).getPlantName(), GPAGE); 
    plant2.setPos(plant2.getPosFromIndex(1, 0, (int) plant2.size.x/2 + 25, (int) plant2.size.y*4 + 25, 3, 4));
    addElement(plant2);
    
    plant3 = new Button(150, 50, color(104, 160, 215), color(75, 117, 159), color(0), garden.getPlants().get(2).getPlantName(), GPAGE); 
    plant3.setPos(plant3.getPosFromIndex(2, 0, (int) plant3.size.x/2 + 25, (int) plant3.size.y*4 + 25, 3, 4));
    addElement(plant3);
    
    //PieChart(int xpos, int ypos, int _radius, float _status)
    // For plant 1
    PieChart chart1 = new PieChart(0, 0, 50, garden.getPlants().get(0).getStatus());
    chart1.setPos(chart1.getPosFromIndex(0, 1, (int) chart1.radius + 110, 5*(int) chart1.radius - 20, 3, 4));
    addElement(chart1);
    
    // For plant 2
    PieChart chart2 = new PieChart(0, 0, 50, garden.getPlants().get(1).getStatus());
    chart2.setPos(chart2.getPosFromIndex(1, 1, (int) chart2.radius + 110, 5*(int) chart2.radius - 20, 3, 4));
    addElement(chart2);
    
    // For plant 3
    PieChart chart3 = new PieChart(0, 0, 50, garden.getPlants().get(2).getStatus());
    chart3.setPos(chart3.getPosFromIndex(2, 1, (int) chart3.radius + 110, 5*(int) chart3.radius - 20, 3, 4));
    addElement(chart3);
    
    backButton = new Button(70, 40, color(104, 160, 215), color(75, 117, 159), color(0), "BACK", GPAGE);
    backButton.setPos(backButton.getPosFromIndex(3, 2, (int) backButton.size.x, (int) backButton.size.y + 100, 3, 4));
    addElement(backButton);
    
  }
  //Renders all the elements on the panel in a loop
  //Tests if its an updatable element (PieChart/ProgressBar) and updates them each call of render
  void render() {
    int index = 0;
    printText();
    for (PageElement p : this.getElements()) {
      if (p instanceof PieChart) {
        garden.plants.get(index).updatePlant();
        ((PieChart) p).update(garden.plants.get(index).status);
        index++;
      }
      p.update();
      p.render();
    }
    if(backButton.isPressed()) {
      PAGE = 0;
    }
    else if(plant1.isPressed()) {
      PAGE = 2;
    }
    else if(plant2.isPressed()) {
      PAGE = 3;
    }
    else if(plant3.isPressed()) {
      PAGE = 4;
    }
  }
  
  void printText() {
    textSize(40);
    text("GARDEN", 500, 100);
    rectMode(CENTER);
    fill(0);
    
    // For chart1 or plant1
    textSize(20);
    text("OVERALL HEALTH = " + 100*garden.getPlants().get(0).getStatus() + "%", 800, 230);
    rectMode(CENTER);
    fill(0);
    
    // For chart2 or plant2
    textSize(20);
    text("OVERALL HEALTH = " + 100*garden.getPlants().get(1).getStatus() + "%", 800, 480);
    rectMode(CENTER);
    fill(0);
    
    // For chart3 or plant3
    textSize(20);
    text("OVERALL HEALTH = " + 100*garden.getPlants().get(2).getStatus() + "%", 800, 730);
    rectMode(CENTER);
    fill(0);
    
  }
  
  Garden getGarden() { 
    return garden; 
  }
  
  int getPanelPage() {
    return GPAGE; 
  }
}

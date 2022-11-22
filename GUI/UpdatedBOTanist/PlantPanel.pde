static final int PLPAGE = 2;

class PlantPanel extends Panel {
  Plant plant;
  ProgressBar moistureBar, lightBar, humidityBar;
  Button backButton;
  
  PlantPanel(Plant _plant) {
    super();
    plant = _plant;

    // Progress bars for each measurable (moisture, temperature, humidity, etc.)
    moistureBar = new ProgressBar(0, 0, 200, 40, plant.getPlantData().get("Moisture"));
    //println("bar = " + plant.getPlantData().get("Moisture"));
    moistureBar.setPos(moistureBar.getPosFromIndex(1, 1, 3*moistureBar.len/5 + 40, 200, 3, 5));
    addElement(moistureBar);
        
    lightBar = new ProgressBar(0, 0, 200, 40, plant.getPlantData().get("Sunlight"));
    //println("bar = " + plant.getPlantData().get("Sunlight"));
    lightBar.setPos(lightBar.getPosFromIndex(3, 1, 3*lightBar.len/5 + 40, 200, 3, 5));
    addElement(lightBar);
    
    humidityBar = new ProgressBar(0, 0, 200, 40, plant.getPlantData().get("Humidity"));
    //println("bar = " + plant.getPlantData().get("Humidity"));
    humidityBar.setPos(humidityBar.getPosFromIndex(2, 1, 3*humidityBar.len/5 + 40, 200, 3, 5));
    addElement(humidityBar);
    
    //Button(int xsize, int ysize, color _rectColor, color highlight, color _textColor, String _text)
    //getPosFromIndex(int row, int col, int xoff, int yoff, int xsize, int ysize)
    backButton = new Button(70, 40, color(104, 160, 215), color(75, 117, 159), color(0), "BACK", PLPAGE);
    backButton.setPos(backButton.getPosFromIndex(3, 1, (int) backButton.size.x, (int) backButton.size.y + 100, 3, 4));
    addElement(backButton);
  }
  
  void render() {
    printText();
    for (PageElement p : this.getElements()) {
      p.update();
      p.render();
    }
    
    if(backButton.isPressed()) {
      PAGE = 1;
    }
    
    moistureBar.update(plant.getPlantData().get("Moisture"));
    lightBar.update(plant.getPlantData().get("Sunlight"));
    humidityBar.update(plant.getPlantData().get("Humidity"));
  }
  void printText() {
    textSize(40);
    text(plant.getPlantName(), 500, 100);
    rectMode(CENTER);
    fill(0);
    
    // Previously water
    textSize(30);
    text("TEMPERATURE: " + GLOBALTEMP, 500, 140);
    rectMode(CENTER);
    fill(0);
    
    // Put actual measured data within string
    int y = 330;
    textSize(30);
    text("MOISTURE", 150, 400);
    rectMode(CENTER);
    fill(0);

    textSize(30);
    text("HUMIDITY", 150, 600);
    rectMode(CENTER);
    fill(0);
    
    textSize(30);
    text("LIGHT", 150, 800);
    rectMode(CENTER);
    fill(0);
    
    // For moisture
    textSize(20);
    text(100*plant.getPlantData().get("Moisture") + "%", 800, (200 + y*1/1.7));
    rectMode(CENTER);
    fill(0);
    
    // For sunlight, changed to humidity
    textSize(20);
    text(100*plant.getPlantData().get("Humidity") + "%", 800, (200 + y*2/1.7));
    rectMode(CENTER);
    fill(0);
    
    // For humidity, changed to sunlight
    textSize(20);
    text(100*plant.getPlantData().get("Sunlight") + "%", 800, (200 + y*3/1.7));
    rectMode(CENTER);
    fill(0);
  }
  
  Plant getPlant() {
     return plant; 
  }
  
  int getPanelPage() {
    return GPAGE; 
  }
}

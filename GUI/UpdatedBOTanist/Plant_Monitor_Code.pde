// https://forum.processing.org/two/discussion/558/creating-a-next-page-button.html
// "Back" button panel implementation reference above
import processing.serial.*;
import java.util.*;
String inBuffer;
float GLOBALTEMP;
// Change page value (0-2) to look at each page.
// Home = 0, Garden = 1, Plant1 = 2, Plant2 = 3, Plant3 = 4
int PAGE = 0; 
HomePanel homePanel;

GardenPanel gardenPanel;
Garden garden, garden2, garden3;

PlantPanel plantPanel, plantPanel2, plantPanel3;
Plant plant1, plant2, plant3;

Serial sensorPort;

void setup() {
  size(1000, 1000);
  background(0);
  //frameRate(120);
  
  garden = new Garden("GARDEN #1");
  
  // In order to retrieve a value, use get("<String>") i.e (get("Moisture"));
  plant1 = new Plant("PLANT #1");
  plant1.addPlantData("Moisture", 0.0);
  plant1.addPlantData("Humidity", 0.0);
  plant1.addPlantData("Sunlight", 0.0);
             
  garden.addPlant(plant1);
  
  plant2 = new Plant("PLANT #2");
  plant2.addPlantData("Moisture", 0.0);
  plant2.addPlantData("Sunlight", 0.0);
  plant2.addPlantData("Humidity", 0.0);
             
  garden.addPlant(plant2);
  
  plant3 = new Plant("PLANT #3");
  plant3.addPlantData("Moisture", 0.0);
  plant3.addPlantData("Sunlight", 0.0);
  plant3.addPlantData("Humidity", 0.0);
             
  garden.addPlant(plant3);
  
  gardenPanel = new GardenPanel(garden);
  
  homePanel = new HomePanel(garden);
  
  // In plant panel, we are only looking at plant1
  plantPanel = new PlantPanel(plant1);
  plantPanel2 = new PlantPanel(plant2);
  plantPanel3 = new PlantPanel(plant3);
  
  sensorPort = new Serial(this, Serial.list()[1], 115200);
 
}

void draw() {
  background(64);
  //dataToPlant(0,0.5,0.5,0.5,0.5);
  //dataToPlant(1,0.7,0.7,0.7,0.7);
  //dataToPlant(2,0.9,0.9,0.9,0.9);
  readArduinoData();
  selectPage();
  redraw();
}

void selectPage() {
   switch(PAGE) {
     
     // Home page
     case 0:
       homePanel.render();
       break;
       
     // Garden page
     case 1:
       gardenPanel.render();
       break;
       
     // Plant 1 page
     case 2:
       plantPanel.render();
       break;
    // Plant 2 page
    case 3:
       plantPanel2.render();
       break;
    
    // Plant 3 page
    case 4:
       plantPanel3.render();
       break; 
   }
}

// Temp = 70, Humidity(%) = 40, Light = 1000, Moisture(%) = 80
void dataToPlant(int plant, float moisture, float humidity, float light) {
  // Update plant 1
  if(plant == 0) {
   plant1.addPlantData("Moisture", moisture);
   plant1.addPlantData("Humidity", humidity);
   plant1.addPlantData("Sunlight", light);
   plant1.updatePlant();
  }
  
  // Update plant 2
  else if(plant == 1) {
   plant2.addPlantData("Moisture", moisture);
   plant2.addPlantData("Humidity", humidity);
   plant2.addPlantData("Sunlight", light); 
   plant2.updatePlant();
  }
  
  // Update plant 3
  else if(plant == 2) {
   plant3.addPlantData("Moisture", moisture);
   plant3.addPlantData("Humidity", humidity);
   plant3.addPlantData("Sunlight", light);
   plant3.updatePlant();
  }
}

void readArduinoData() {
  inBuffer = "";
   try {
    while (sensorPort.available() > 0) {
      
      inBuffer = sensorPort.readString();   
      if(inBuffer != null) {
        
      }
    }
    } catch (NullPointerException e) {
    }
    if (inBuffer.length() > 0) {
      List<String> arr = Arrays.asList(inBuffer.split(" "));
      println(arr.toString());
      //println(arr.size());
      if (arr.size() == 6) { 
        try {
          
          int plantIndex = Integer.parseInt(arr.get(0));
          
          float temp = Float.parseFloat(arr.get(1));
          //temp += 70; // 1 - abs(constrain(map(temp, -40, 40, -1, 1), -1, 1));
          
          float humid = Float.parseFloat(arr.get(2));
          humid = 1 - abs(constrain(map(humid, -10, 10, -1, 1), -1, 1));
          
          float light = Float.parseFloat(arr.get(3));
          light = 1 - abs(constrain(map(light, -1500, 1500, -1, 1), -1, 1));
          
          float moist = Float.parseFloat(arr.get(4));
          moist = 1 - abs(constrain(map(moist, -100, 100, -1, 1), -1, 1));
     
          dataToPlant(plantIndex, moist, humid, light); // Fix temperature
          GLOBALTEMP = temp + 70;
          println(plantIndex + " "  + temp + " " + humid + " " + light + " " + moist);
          
      } catch (NumberFormatException e) {}
    }
  }
}

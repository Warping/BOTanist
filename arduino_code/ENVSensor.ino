/*
 * This program uses garden data to control a simple FSM
 * The system takes in light/soil moisture/temperature/humidity
 * to monitor and maintain plants using a solenoid valve for water
 * and a UV light for artificial sunlight
 */


#include "DFRobot_EnvironmentalSensor.h"
#include <WiFi.h>

#define SLEEP_TIMER 5
#define PLANTS 3
#define GLOBAL_DATA 3

#define WATER_PIN_1 25
#define WATER_PIN_2 26
#define WATER_PIN_3 14
#define PUMP_PIN     2
#define LIGHT_PIN   13
#define FAN_PIN      4

#define GARDEN_INDEX 0

DFRobot_EnvironmentalSensor environment(0x22, &Wire);

//6 data points for light/moisture etc...
float gardenData[PLANTS + GLOBAL_DATA];

/*
 * target values for each plant [Temp, Humid, Light, Soil Value]
 *                              [Temp, Humid, Light, Soil Value]
 *                             
 */

float plantStatus[PLANTS*(GLOBAL_DATA + 1)];
float plantChanges[PLANTS*(GLOBAL_DATA + 1)];

float plantTargets[PLANTS*(GLOBAL_DATA + 1)];

const float soilAirVal = 400.0;
const float soilWaterVal = 150.0;

const float tempRange = 2.0;
const float humidRange = 5.0;
const float lightRange = 300.0;
const float soilRange = 15.0;

float tempDelta;
float humidDelta;
float lightDelta;
float soilDelta;

int currentParameter = 0;

enum State {
  Read,
  Compare,
  UpdateParams
};

State nextState = Read;

State calcNextState() {
  switch (nextState) {
    case Read:
      //Serial.println("Reading Data");
      neopixelWrite(5,64,64,0);
      grabGardenData();
      //Serial.println();
      delay(100);
      return Compare;
      break;
      
    case Compare:
      //Serial.println("Comparing Data");
      neopixelWrite(5,0,64,0);
      compareGardenData();
      delay(100);
      return UpdateParams;
      break;
      
    case UpdateParams:
      //Serial.println("Update Data");
      neopixelWrite(5,64,64,64);
      updateGardenParams();
      delay(500);
      return Read;
      break;
  }
}

void setup()
{
  pinMode(WATER_PIN_1, OUTPUT);
  pinMode(WATER_PIN_2, OUTPUT);
  pinMode(WATER_PIN_3, OUTPUT);
  pinMode(LIGHT_PIN, OUTPUT);
  pinMode(PUMP_PIN, OUTPUT);
  pinMode(FAN_PIN, OUTPUT);
  
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
  pinMode(A2, INPUT);
  analogReadResolution(9);
  Serial.begin(115200);
  while(environment.begin() != 0){
    Serial.println("Sensor initialize failed!!");
    delay(1000);
  }
  Serial.println("Sensor  initialize success!!");
  //neopixelWrite(5,0,0,64);
  for (int i = 0; i < PLANTS; i++) {
    plantTargets[(GLOBAL_DATA + 1)*i + 0] = 70.0;   //+ random(-5,5); //Temp
    plantTargets[(GLOBAL_DATA + 1)*i + 1] = 40.0;   //+ random(-5,5); //Humid %
    plantTargets[(GLOBAL_DATA + 1)*i + 2] = 1000.0; //+ random(-100,100); //Lux
    plantTargets[(GLOBAL_DATA + 1)*i + 3] = 35.0;   //+ random(-5,5); //Soil Moisture %
  }
}

void loop() {
  //Print the data obtained from sensor
  //grabGardenData();
  //sendGardenData();
  //delay(500);
  //sleep(5);

  nextState = calcNextState();
}
/*
 * Format for plant data
 * {Garden index} {Temp} {Humidity} {Light} {Plant0 Soil} {Plant1 Soil} {Plant2 Soil}
 */
void sendGardenData() {
  Serial.print(GARDEN_INDEX);
  for (int i = 0; i < PLANTS + GLOBAL_DATA; i++) {
    space();
    Serial.print(gardenData[i]);
  }
  Serial.println();
}

void space() {
  Serial.print(" ");
}

void sleep(int seconds) {
  esp_sleep_enable_timer_wakeup(seconds * 1000000);
  esp_deep_sleep_start();
}

void updateGardenParams() {
  //Serial.println("Parameters to Change...");
  for (int i = 0; i < PLANTS; i++) {
    tempDelta = plantChanges[(GLOBAL_DATA + 1)*i + 0]; //Temp
    humidDelta = plantChanges[(GLOBAL_DATA + 1)*i + 1]; //Humid %
    lightDelta = plantChanges[(GLOBAL_DATA + 1)*i + 2]; //Lux
    soilDelta = plantChanges[(GLOBAL_DATA + 1)*i + 3]; //Soil Moisture %
    //Serial.println("-----------------------------------");
    //Serial.print("Temp ");
    //Serial.print(i);
    //if (tempDelta < -tempRange) {}//Serial.println(" Increase!");}
    //else if (tempDelta > tempRange) {}//Serial.println(" Decrease!");}
    //else  {Serial.println(" Stable");}

    //Serial.print("Humidity ");
    //Serial.print(i);
    if (humidDelta < -humidRange) {
      //Serial.println(" Increase!");
      if (i==0) digitalWrite(FAN_PIN, HIGH);
    }
    else if (humidDelta > humidRange) {
      //Serial.println(" Decrease!");
      if (i==0) digitalWrite(FAN_PIN, LOW);
    }
    else {
      //Serial.println(" Stable");
      if (i==0) digitalWrite(FAN_PIN, LOW);
    }

    //Serial.print("Light ");
    //Serial.print(i);
    if (lightDelta < -lightRange) {
      //Serial.println(" Increase!");
      if (i==0) digitalWrite(LIGHT_PIN, HIGH);
    }
    else if (lightDelta > lightRange) {
      //Serial.println(" Decrease!");
      if (i==0) digitalWrite(LIGHT_PIN, LOW);
    }
    else  {
      //Serial.println(" Stable");
      if (i==0) digitalWrite(LIGHT_PIN, LOW);
    }

    //Serial.print("Soil Moisture ");
    //Serial.print(i);
    if (soilDelta < -soilRange) {
      //Serial.println(" Increase!");
      if (i==0) digitalWrite(WATER_PIN_1, HIGH);
      if (i==1) digitalWrite(WATER_PIN_2, HIGH);
      if (i==2) digitalWrite(WATER_PIN_3, HIGH);
    }
    else if (soilDelta > soilRange) {
      //Serial.println(" Decrease!");
      if (i==0) digitalWrite(WATER_PIN_1, LOW);
      if (i==1) digitalWrite(WATER_PIN_2, LOW);
      if (i==2) digitalWrite(WATER_PIN_3, LOW);
    }
    else {
      //Serial.println(" Stable");
      if (i==0) digitalWrite(WATER_PIN_1, LOW);
      if (i==1) digitalWrite(WATER_PIN_2, LOW);
      if (i==2) digitalWrite(WATER_PIN_3, LOW);
    }
  }
  if (digitalRead(WATER_PIN_1) || digitalRead(WATER_PIN_2) || digitalRead(WATER_PIN_3)) {
    digitalWrite(PUMP_PIN, HIGH);
    //Serial.println("Pump On!");
  } else {
    digitalWrite(PUMP_PIN, LOW);
    //Serial.println("Pump Off!");
  }
  //Serial.println();
}

void grabGardenData() {
  gardenData[0] = environment.getTemperature(TEMP_F);
  gardenData[1] = environment.getHumidity();
  gardenData[2] = environment.getLuminousIntensity();
  
  gardenData[3] = map(analogRead(A2), soilWaterVal, soilAirVal, 100, 0);
  gardenData[4] = map(analogRead(A1), soilWaterVal, soilAirVal, 100, 0);
  gardenData[5] = map(analogRead(A0), soilWaterVal, soilAirVal, 100, 0);

  for (int i = 0; i < PLANTS; i++) {
    for (int j = 0; j < GLOBAL_DATA; j++) {
      plantStatus[(GLOBAL_DATA + 1)*i + j] = gardenData[j];
      //Serial.print(gardenData[j]);
      //Serial.print(" ");
    }
    plantStatus[(GLOBAL_DATA + 1)*i + GLOBAL_DATA] = gardenData[GLOBAL_DATA + i];
    //Serial.print(gardenData[GLOBAL_DATA + i]);
    //Serial.println();
  }
}

void compareGardenData() {
  for (int i = 0; i < PLANTS; i++) {
    Serial.print(i);
    Serial.print(" ");
    for (int j = 0; j < GLOBAL_DATA + 1; j++) {
      plantChanges[(GLOBAL_DATA + 1)*i + j] = plantStatus[(GLOBAL_DATA + 1)*i + j] - plantTargets[(GLOBAL_DATA + 1)*i + j];
      Serial.print(plantChanges[(GLOBAL_DATA + 1)*i + j]);
      Serial.print(" ");
    }
    Serial.println();
    delay(100);
  }
}

//Searches for Active Wifi Networks
void searchNetworks() {
 
  int numberOfNetworks = WiFi.scanNetworks();
 
  Serial.print("Number of networks found: ");
  Serial.println(numberOfNetworks);
 
  for (int i = 0; i < numberOfNetworks; i++) {
    Serial.print("Network name: ");
    Serial.println(WiFi.SSID(i));
  }
}


//Initializes Wifi
void initWiFi(char* ssid, char* pass) {
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, pass);
  Serial.print("Connecting to WiFi ..");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print('.');
    delay(1000);
  }
  Serial.println(WiFi.localIP());
}

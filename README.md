
Requires: 
1) FireBeetle ESP32 
2) Fermion Environmental Sensor (I2C)
3) 3 Water Capacitive Sensors (Analog)
4) Arduino IDE


To setup you'll need to go to File>Preferences> and click the window icon next to additional board managers URL and add this line

https://git.oschina.net/dfrobot/FireBeetle-ESP32/raw/master/package_esp32_index.json

Setup:

1) Go to Tools>Boards>Board Manager and search "esp32". install the first thing it says. 
2) Go to Tools>Board>ESP32 Arduino, then find FireBeetle-ESP32
3) Once thats done u can upload the code

GUI:

Run the GUI by running Plant_Monitor_Code in the GUI folder. Make sure no other COM devices are being used.

NOTE: Cannot run serial monitor AND GUI at the same time

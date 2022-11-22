class Plant {
  
  String name;
  HashMap<String, Float> data;
  float status;
  
  Plant(String _name, HashMap<String, Float> _data) {
    name = _name;
    data = new HashMap<String, Float>(_data);
  }
  
  Plant(String _name) {
    name = _name;
    data = new HashMap<String, Float>();
  }
  
  void setPlantName(String _name) {
    name = _name;
  }
  
  String getPlantName() {
    return name; 
  }
  
  void addPlantData(String keyword, Float val) {
    data.put(keyword, val);
  }
  
  void setPlantData(HashMap<String, Float> _data) {
    data = new HashMap<String, Float>(_data);
  }
  
  void updatePlant() {
    status = 0;
    for (Float v : data.values()) {
      status += v;
    }
    status /= data.values().size();
  }
  
  HashMap<String, Float> getPlantData() {
    return data;
  }

  float getStatus() {
    updatePlant();
    return status; 
  }
}

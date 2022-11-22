class Garden {
  
  String name;
  ArrayList<Plant> plants;

  Garden(String _name, ArrayList<Plant> _plants) {
    name = _name;
    plants = new ArrayList<>(_plants);
  }
  
  Garden(String _name) {
    name = _name;
    plants = new ArrayList<>();
  }
  
  String getGardenName() {
     return name; 
  }
  
  void removePlant(Plant _plant) {
    plants.remove(_plant);
  }
  
  void addPlant(Plant _plant) {
    plants.add(_plant);
  }
  
  ArrayList<Plant> getPlants() {
    return plants;
  }
}

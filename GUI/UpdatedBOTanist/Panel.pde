abstract class Panel {

  ArrayList<PageElement> elements;
  
  Panel(ArrayList<PageElement> _elements) {
    elements = new ArrayList<>(_elements);
  }
  
  Panel() {
    elements = new ArrayList<>();
  }
  
  void addElement(PageElement element) {
    elements.add(element);
  }
  
  void removeElement(PageElement element) {
    elements.remove(element);
  }
  
  void render() {
    for (PageElement element : elements) {
      element.update();
      element.render();
    }
  }
  
  ArrayList<PageElement> getElements() {
    return elements;
  }
}

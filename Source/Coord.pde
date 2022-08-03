class Coord {
  float x, y;
  
  Coord(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  @Override
  public String toString() {
    return "(" + x + ", " + y + ")";
  }
}

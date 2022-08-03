class Grill {
  float size_w, size_h;
  int w, h;
  int num_c, num_r;
  
  Grill(int num_c, int num_r, int w, int h) {
    this.w = w;
    this.h = h;
    this.num_c = num_c;
    this.num_r = num_r;
    
    size_w = (float) w / num_c ;
    size_h = (float) h / num_r;
  }
  
  public void display() {
    //Color
    fill(0);
    
    //Vertical lines
    for (float i = 0; i <= size_w*num_c; i += size_w) {
      stroke(0);
      strokeWeight(1);
      
      line(i, 0, i, h);
    }
    
    //Horizontal Lines
    for (float i = 0; i <= size_h*num_r; i += size_h) {
      stroke(0);
      strokeWeight(1);
      
      line(0, i, w, i);
    }
    
  }
}

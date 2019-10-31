
Slider s = new Slider(0, 100, 50); // min, max, default

void setup() {
  size(500, 500);
  s.position(100, 100); // x, y
}

void draw() {
  background(200);
  square(100, 300, s.value()); // .value() retorna o valor E desenha o slider
}


class Slider // baseada no slider do Peter Farell https://github.com/hackingmath/
{
  float x = 0;
  float y = 0;
  float low, high, def;
  float rectx, recty, val;
  boolean clicked;
  String label;
  
  Slider(float low_, float high_, float def_) {
    /*slider has range from low to high
     and is set to def*/
    low = low_;
    high = high_;
    val = def_;
    clicked = false;
    label = ""; //blank label
  }    
  void position(float x_, float y_) {
    //slider"s position on screen//
    x = x_;
    y = y_;
    //the position of the rect you slide{
    rectx = x + map(val, low, high, 0, 120);
    recty = y - 10;
  }   
  float value() {
    //updates the slider and returns value//
    //gray line behind slider
    strokeWeight(4);
    stroke(100);
    line(x, y, x + 120, y);
    //press mouse to move slider
    if (mousePressed && dist(mouseX, mouseY, rectx, recty) < 20) {
      rectx = mouseX;
    }
    //constrain rectangle
    rectx = constrain(rectx, x, x + 120);
    //draw rectangle
    strokeWeight(1);
    stroke(0);
    fill(255);
    rect(rectx, recty, 10, 20);
    float val = map(rectx, x, x + 120, low, high);
    //draw label
    fill(0);
    textSize(10);
    text(int(val), rectx, recty + 35);
    //text label
    text(label, x + 135, y);
    return val;
  }
}

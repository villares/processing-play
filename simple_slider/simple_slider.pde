
Slider s = new Slider(0, 300, 50); // min, max, default

void setup() {
  size(500, 500);
  s.position(50, 50); // x, y
}

void draw() {
  background(200);
  translate(250, 50);
  rotate(QUARTER_PI);
  square(0, 0, s.value()); // value() retorna o valor E desenha o slider
}


class Slider
{
  // sliders based on Peter Farell's Sliders htts://github.com/hackingmath
  float x = 0;
  float y = 0;
  float low, high, def;
  float rectx, recty, val;
  boolean clicked;
  String label;
  int sliderW = 120;
  int sliderH = 20;

  Slider(float low_, float high_, float def_) {
    /* slider has range from low to high
       and is set to def */
    low = low_;
    high = high_;
    val = def_;
    clicked = false;
    label = ""; //blank label
  }    
  void position(float x_, float y_) {
    // slider"s position on screen//
    x = x_;
    y = y_;
    // the position of the rect you slide
    rectx = x + map(val, low, high, 0, sliderW);
    recty = y;
  }   
  float value() {
    // updates the slider and returns value
    // press mouse to move slider
    if (mousePressed && dist(mouseX, mouseY, rectx, recty) < sliderH) {
      rectx = mouseX;
    }
    pushMatrix();
    resetMatrix();
    pushStyle();
    rectMode(CENTER);
    // gray line behind slider
    strokeWeight(4);
    stroke(100);
    line(x, y, x + sliderW, y);
    // constrain rectangle
    rectx = constrain(rectx, x, x + sliderW);
    // draw rectangle
    strokeWeight(1);
    stroke(0);
    fill(255);
    rect(rectx, recty, sliderW / 12, sliderH);
    float val = map(rectx, x, x + sliderW, low, high);
    // draw label
    fill(0);
    textSize(10);
    textAlign(CENTER, CENTER);
    text(int(val), rectx, recty + sliderH);
    // text label
    text(label, x + sliderW + 20, y);
    popStyle();
    popMatrix();
    return val;
  }
}

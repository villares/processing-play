void setup() {
  rectMode(CENTER);
  size(200, 200);
  rectangle(100, 100, QUARTER_PI, 50, 20);
  ellipse(100, 100, 10, 10);
}

void rectangle(float x, float y, float ang, float w, float h) {
  pushMatrix();
  translate(x, y);
  rotate(ang);
  rect(0, 0, w, h);
  popMatrix();
}

void seta(float x1, float y1, float x2, float y2, float encurtamento, float head) {
  float L = dist(x1, y1, x2, y2);
  pushMatrix();
  translate(x1, y1);
  float angle = atan2(x1 - x2, y2 - y1);
  rotate(angle);
  float offset = encurtamento / 2;
  strokeCap(ROUND);
  line(0, L - offset, -head / 3, L - offset - head);
  line(0, L - offset, head / 3, L - offset - head);
  strokeCap(SQUARE);
  line(0, offset, 0, L - offset);
  popMatrix();
}

void seta(float x1, float y1, float x2, float y2) {
  seta(x1, y1, x2, y2, 10, 15); // default tamanho=10, head=15
}

void setup() {
  size(400, 400);
  strokeWeight(3);
}

void draw() {
  background(200);
  stroke(128);
  ellipse(200, 140, 10, 10);
  ellipse(100, 100, 10, 10);
  stroke(0);
  seta(100, 100, 200, 140);
}


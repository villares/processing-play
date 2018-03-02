void setup() {
  size(400, 400);
}
void draw() {
  background(200);
  ellipse(100, 100, 10, 10);
  strokeWeight(3);
  seta(100, 100, 200, 140, 10, 15);
  ellipse(200, 140, 10, 10);
}
void seta(float x1, float y1, float x2, float y2) {
  seta(x1, y1, x2, y2, 12, 12); //tamanho=12, head=12
}

void seta(float x1, float y1, float x2, float y2, float encurtamento, float head) {
  float d = dist(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float angle = atan2(x1 - x2, y2 - y1);
  rotate(angle);
  float offset = -encurtamento * .6;
  strokeCap(SQUARE);
  line(0, offset, 0, -d - offset);
  line(0, offset, -head / 3, -head + offset);
  line(0, offset, head / 3, -head + offset);
  popMatrix();
}
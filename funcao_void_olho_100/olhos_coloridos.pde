void setup() {
  size(400, 400);
  background(0);
  for (int i = 0; i <20; i++) {
    olho(random(width), random(height), random(50, 100));
  }
}

void olho(float x, float y, float tamanho) {
  noStroke();
  fill(255);
  ellipse(x, y, tamanho, tamanho/2);
  fill(random(256), random(256), random(256));
  ellipse(x, y, tamanho*.40, tamanho*.40);
  fill(0);
  ellipse(x, y, tamanho*.10, tamanho*.10);
}
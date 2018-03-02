
void setup() {
  size(400, 400);
}

void draw() {
  for (int y = 0; y < height; y += 20) {
    for (int x=0; x < width; x += 20) {
      xadrez(x, y, 10);
    }
  }
  xadrez(50, 30, 20);
}

void xadrez(float x, float y, float tam) {
  fill(255);
  rect(x, y, tam, tam);
  rect(x+tam, y+tam, tam, tam);  
  fill(0);
  rect(x+tam, y, tam, tam);
  rect(x, y+tam, tam, tam);
}
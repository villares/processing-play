/* 
arteprog - arte e programação
http://arteprog.space
*/

void olho(float x, float y, float tamanho) {
  noStroke();
  // branco    
  fill(255); 
  ellipse(x, y, tamanho, tamanho/2);
  // iris
  fill(random(256), random(256), random(256));
  ellipse(x, y, tamanho*.40, tamanho*.40);
  // pupila
  fill(0);
  ellipse(x, y, tamanho*.10, tamanho*.10);
}

void setup() {
  size(1000, 1000);
  background(0);
  for (int i = 0; i <100; i++) {
    olho(random(width), random(height), random(100, 200));
  }
  saveFrame("100olhos.png");
}
/*
 Exemplo de Perlin Noise em duas dimensões 
 
 "There have been debates over the accuracy of the implementation of noise in Processing.
 For clarification, it's an implementation of "classic Perlin noise" from 1983,
 and not the newer "simplex noise" method from 2001. "
 */

float perlinScale = 0.1;

void setup() {
  size(500, 500); // define o tamanho da tela em pixels. Largura X Altura
  noStroke();
  colorMode(HSB);
}

void draw() {
  background(0);
  int cols = 50;
  float tam = width / cols;
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < cols; y++) {
      float n = noise((mouseX+x)*perlinScale, (mouseY+y)*perlinScale);
      fill(240 * n, 255, 255);
      ellipse(tam/2 + x * tam, tam/2 + y * tam, tam - tam * n, tam - tam * n);
    }
  }
}

void setup() {
  size(400, 400);
}

void draw() {
  background(0);
  olho(300, 100, random(50, 100));
  olho(100, 200, random(10, 150)); 
  olho(200, 300, random(10, 150));
  
  println(int(random(1, 11)));
}

void olho(float x, float y, float tamanho) {
  noStroke();
  fill(255);
  ellipse(x, y, tamanho, tamanho/2);
  fill(0);
  ellipse(x, y, tamanho*.40, tamanho*.40);
}
//Bola bola0;
ArrayList<Bola> bolas;

void setup() {
  size(600, 400);
  noStroke();
  //bola0 = new Bola(100, 100, 30, 40);
  bolas = new ArrayList<Bola>();
  bolas.add(new Bola(random(width),
                     random(height),
                     50, 70)); // min e max para sorteio tamanho
}

void draw() {
  background(128);
  //bola0.desenhar();
  //bola0.mover();
  for (Bola bola : bolas) {
    bola.desenhar();  
    bola.mover();
  }
}

void mousePressed() {
  bolas.add(new Bola(mouseX, mouseY, 20, 40));
}

class Bola {
  float x, y, vx, vy, tamanho;
  color cor;
  Bola(float px, float py, float tam_min, float tam_max) {
    x = px;
    y = py;
    tamanho = random(tam_min, tam_max);
    cor = color(random(255), random(255), random(255), 100);
    vx = random(-2, 2);
    vy = random(-2, 2);
  }
  void desenhar() {
    fill(cor);
    ellipse ( x, y, tamanho, tamanho);
  }
  void mover() {
    x = x + vx;
    if (x < 0 || x > width) { 
      vx = -vx;
    }
    y = y + vy;
    if (y < 0 || y > height) { 
      vy = -vy;
    }
  }
}

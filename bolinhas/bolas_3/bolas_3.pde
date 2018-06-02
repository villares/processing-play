/* Exemplo de um sistema de partículas com lista dinâmica 'ArrayList' 
 * A classe grupoDeBolas contém uma lista de bolinhas da classe Bola
 * A festa é ArrayList de grupoDeBolas (uma lista de grupos de bolinhas)
 */

ArrayList<grupoDeBolas> festa; 

void setup() {
  size(600, 400);
  noStroke();
  festa = new ArrayList<grupoDeBolas>(); // festa é uma lista de grupos de bolas
}

void draw() {
  background(100);
  for (grupoDeBolas grupo : festa) {  // para cada lista da festa
    grupo.update();
  }

  for (int i = festa.size()-1; i >= 0; i--) {  // percorre a festa, do fim para o começo
    grupoDeBolas grupo = festa.get(i);  // pega um grupo
    if (grupo.bolas.size() == 0) {      // se o grupo estiver vazio
      festa.remove(i);                  // remove o grupo da festa
    }
  }
}

void mousePressed() {
  festa.add(new grupoDeBolas(mouseX, mouseY, 50));
}

class Bola {
  float x, y, vx, vy, tamanho;
  color cor;
  Bola(float px, float py, float tam_min, float tam_max) {
    x = px;
    y = py;
    tamanho = random(tam_min, tam_max);
    colorMode(HSB);
    cor = color(random(100, 200), 255, 255);
    vx = random(-2, 2);
    vy = random(-2, 2);
  }
  void desenhar() {
    fill(cor);
    ellipse ( x, y, tamanho, tamanho);
  }
  void mover() {
    tamanho = tamanho * .995;
    x = x + vx;
    if (x < 0 || x > width) { 
      vx = -vx;
    }
    vy = vy + 0.02;
    y = y + vy;
    if (y < 0) { 
      vy = -vy;
    }
  }
}

class grupoDeBolas {
  ArrayList<Bola> bolas;  // lista de bolas do grupo
  // construtor
  grupoDeBolas(float px, float py, int num) {
    bolas = new ArrayList<Bola>();
    for (int i = 0; i < num; i++) {
      bolas.add(new Bola(px, py, 5, 20));
    }
  }

  void update() {
    for (Bola bola : bolas) {
      bola.desenhar();  
      bola.mover();
    }
    // remove bolas que sairam para baixo do canvas
    for (int i = bolas.size()-1; i >= 0; i--) { 
      Bola bola = bolas.get(i);
      if (bola.y > height) {
        bolas.remove(i);
      }
    }
  }
}

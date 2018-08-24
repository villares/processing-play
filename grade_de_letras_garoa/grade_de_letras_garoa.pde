/*
 Uma grade de letras
 */

PFont f;
String letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ☂#$*&";

void setup() {
  size(640, 360);
  background(0);
  //Criar uma fonte PFont
  printArray(PFont.list());  // lista de fontes do computador
  f = createFont("GaroaHackerClubeBold.otf", 24);  
  textFont(f);
  textAlign(CENTER, CENTER);
  textSize(24);
  frameRate(2);
} 

void draw() {
  background(0);
  int passo = 25;
  for (int y = 12; y <= height-12; y += passo) {
    for (int x = 12; x <= width-12; x += passo) {
      int sorteio = int(random(letras.length()));
      char letter = letras.charAt(sorteio);
      if (letter == '☂' || letter == '&') {
        fill(0, 200, 0);
      } else {
        fill(255);
      }
      // Desenha a letra na tela
      text(letter, x, y);
    }
  }
}

/*
  Uma grade de letras!
  1. Se não indicarmos uma fonte, uma fonte padrão será usada.
  2. Podemos criar uma PFont a partir de uma fonte já instalada
  3. Podemos criar uma PFont a partir de uma fonte vetorial .ttf ou .otf na pasta /data
  4. Podemos criar uma fonte bitmap a partir de uma fonte vetorial e a partir dela uma PFont
     Com a ferramenta Tool > Create Font...
*/
 
PFont f;
String letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#$*&";
 
void setup() {
  size(640, 360);
  background(0);
  printArray(PFont.list());     // lista de fontes instaladas no computador
  // f = createFont("Bitstream Vera Sans Mono Bold", 24);  // cria uma fonte Pfont
  // textFont(f);                // Indica a fonte que vai ser usada
  textAlign(CENTER, CENTER); // Alinhamento horizontal e vertical
  textSize(24);             // Tamanho do texto
  noLoop();  // Este exemplo para a repetiçao do draw()...
}
 
void draw() {
  background(0);
  int passo = 25;
  for (int y = 12; y <= height-12; y += passo) {
    for (int x = 12; x <= width-12; x += passo) {
      int sorteio = int(random(30));
      char umaLetra = letras.charAt(sorteio);
      if (umaLetra == 'A' || umaLetra == 'E' || umaLetra == 'I'
                           || umaLetra == 'O' || umaLetra == 'U') {
        fill(255, 204, 0);
      } else {
        fill(255);
      }
      // Desenha a letra na tela
      text(umaLetra, x, y);
    }
  }
}

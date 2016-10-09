/***** Primeiro instale a biblioteca "video" pelo IDE!
 * Brilho e ASCII, zoando demos do Daniel Shiffman
 * nos exemplos da biblioteca video do Processing. 
   Tecle 'R' para gravar frames, 'C' para modo colorido,
   1|2 para tamanho da fonte, Setas cima|baixo tamanho da grade
 ***** Install "video" library using the IDE!
 * Brightness and ASCII
 * Messing with Processing demos by coding hero Daniel Shiffman.  
   Press 'R' to toggle saveFrame(),'C' to toggle color mode,
   1|2 to change font size, UP|DOWN to change grid size
 */

import processing.video.*;

int tamanho = 6; // tamanho das células da grade
int tamanhoFonte = 10;
int colunas, filas;
// Varíavel que guarda a captura
Capture video;
boolean gravar = false;
boolean colorido = false;
char[] letters;  

void setup() {
  size(640, 480);
  frameRate(10);
  video = new Capture(this, width, height);
  // Começa a captura
  video.start();  
  PFont fonte = createFont("SourceCodePro-Bold",60);
  textFont(fonte);
  letters = new char[256];
  String letterOrder =
    " .`-_':,;^=+/\"|)\\<>)iv%xclrs{*}I?!][1taeo7zjLu" +
    "nT#JCwfy325Fp6mqSghVd4EgXPGZbYkOA&8U$@KHDBWNMR0Q";
  for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, letterOrder.length()));
    letters[i] = letterOrder.charAt(index);
  }
}

void draw() { 
  colunas = width / tamanho;
  filas = height / tamanho;
  background(0);
  textSize(tamanhoFonte);
  if (video.available()) {
    video.read();
    video.loadPixels();  
    // Loopando as colundas da grade
    for (int i = 0; i < colunas; i++) {
      // Begin loop for rows
      for (int j = 0; j < filas; j++) {
        int x = i*tamanho;
        int y = j*tamanho;
        int loc = x + y*video.width;
        color cor = video.pixels[loc];        
        if (colorido) {
          fill(cor); // letras coloridas
        } else {
          fill(255); // letras em branco
        }                                     
        float lumin = brightness(cor);  // calcula luminosidade do pixel
        text(letters[int(lumin)], x+tamanho/2, y+tamanho/2);
      }
    }
    if (gravar) saveFrame("frame####.png");
  }
}

void keyPressed() {
  if (key=='C'|key=='c') {  
    colorido = !colorido;
    println("colorido: ", colorido);
  }
  if (key=='R'|key=='r') {
    gravar = !gravar;
    println("gravando: ", gravar);
  }
  if (key=='1' && tamanhoFonte>2) {
    tamanhoFonte -= 1;
    println("tamanho da fonte: ", tamanhoFonte);
  }
  if (key=='2') {
    tamanhoFonte += 1;
    println("tamanho da fonte: ", tamanhoFonte);
  }
  if (keyCode==UP) {
    tamanho += 1;
    println("tamanho da grade: ", tamanho);
  }
  if (keyCode==DOWN && tamanho>5) {
    tamanho -= 1;
    println("tamanho da grade: ", tamanho);
  }
}

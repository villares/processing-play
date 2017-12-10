/*
 Retícula de bolinhas brancas a partir da câmera
 Aperte 'g' para gravar um PDF na pasta do sketch
 */
import processing.pdf.*;
import processing.video.*;
int tam_celula = 16; // tamanho das células da grade
int colunas, filas;
Capture video; // Varíavel que guarda a captura
Boolean gravarPDF = false;

void setup() {
  size(640, 480);
  noStroke();
  smooth();
  rectMode(CENTER); 
  colunas = width / tam_celula;
  filas = height / tam_celula;
  video = new Capture(this, width, height);
  // Começa a captura
  video.start();  
  background(0);
}

void draw() { 
  if (video.available()) {
    if (gravarPDF) { 
      fill(0); 
      rect(0, 0, width, height); 
      beginRecord(PDF, "Imagem.pdf");
    }
    background(0);
    video.read();
    video.loadPixels();  
    // Loopando as colunas da grade
    for (int i = 0; i < colunas; i++) {
      // Loop das filas
      for (int j = 0; j < filas; j++) {
        int x = i*tam_celula;
        int y = j*tam_celula;
        int loc = x + y*video.width;
        color cor = video.pixels[loc];
        float tam = map(brightness(cor), 0, 255, 0, tam_celula-1);
        fill(255);
        ellipse(x+tam_celula/2, y+tam_celula/2, tam, tam);
      } // dim fo loop das filas
    } // fim do loop das colunas 
    if (gravarPDF) {   
      endRecord();    
      gravarPDF = false;
    }
  } // fim do if video.available()
} // fim  do draw()

void keyPressed() {
  if (key == 'g') { 
    gravarPDF = true;
  }
}
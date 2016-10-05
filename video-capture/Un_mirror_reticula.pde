/*
  Zoando o 'Mirror2' do Daniel Shiffman
 Messing with Processing demo 'Mirror2' by coding hero Daniel Shiffman.  
 Grid of circles, size varies with the brightness of the captured pixel at the center of each circle
 */

import processing.video.*;
int tamanho = 10; // tamanho das células da grade
int colunas, filas;
// Varíavel que guarda a captura
Capture video;
boolean gravar = false;

void setup() {
  size(640, 480);
  frameRate(10);
  noStroke();
  smooth();
  rectMode(CENTER); 
  colunas = width / tamanho;
  filas = height / tamanho;
  video = new Capture(this, width, height);
  // Começa a captura
  video.start();  
  background(0);
}

void draw() { 
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
        fill(0);                                             // preto
        ellipse(x+tamanho/2, y+tamanho/2, tamanho, tamanho); // círculo preto
        fill(255);                                    // branco
        float lumin = brightness(video.pixels[loc]);  // calcula luminosidade do pixel
        ellipse(x+tamanho/2, y+tamanho/2, tamanho*lumin/255, tamanho*lumin/255);
      }
    }
    if (gravar) saveFrame("frame####.png");
  }
}
void keyPressed() {
  gravar = !gravar;
  println("gravando: ", gravar);
}
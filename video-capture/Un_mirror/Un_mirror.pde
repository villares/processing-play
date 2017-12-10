/*
  Zoando o 'Mirror' do Daniel Shiffman
  Messing with Processing demo 'Mirror' by coding hero Daniel Shiffman.  
  Draws a grid of circles using the color from the pixel at the center of each circle
 */
 
import processing.video.*;
int tamanho = 16; // tamanho das células da grade
int colunas, filas;
// Varíavel que guarda a captura
Capture video;

void setup() {
  size(640, 480);
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
        color c = video.pixels[loc];
        fill(c);
        ellipse(x+tamanho/2, y+tamanho/2, tamanho-1, tamanho-1);
      }
    }
  }
}

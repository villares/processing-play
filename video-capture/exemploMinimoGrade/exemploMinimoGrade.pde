import processing.video.*;
int tamanho = 16; // tamanho das células da grade
int colunas, filas;
// Varíavel que guarda a captura
Capture video;

void setup() {
  size(640, 480);
  noStroke();
  colunas = width / tamanho;
  filas = height / tamanho;
  video = new Capture(this, 640, 480);
  // Começa a captura
  video.start();
}

void draw() { 
  colunas = width / tamanho;
  filas = height / tamanho;
  if (video.available()) {
    background(0);
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
      } // finaldo loop das filas
    } // final das colunas (e da grade!) 
  } // final do if (video.available())
} // final do draw()

void keyPressed(){
 if (key == '-' && tamanho > 1) tamanho--; 
 if (key == '+') tamanho++; 
}


PImage original;
PImage imagem;
boolean vai = false;
char tipo;

void setup() {
  size(1000, 500);
  // use uma imagem de 200 por 200 pixels em /data
  original = loadImage("img.png");
  imagem = original.get();
  imagem.loadPixels();
  println("loaded "+str(imagem.pixels.length));
} 

void draw() {
  scale(2.5);
  background(0);
  image(original, 0, 0);
  image(imagem, 200, 0);
  ellipse(mouseX / 2.5, mouseY / 2.5, 10, 10);
}

void keyPressed() {
  if (!vai) {
    vai = true;
    tipo = key;
    thread("ordena");
  }
}

void ordena() {
  println("modo: " + tipo);
  if (vai) {
    for (int i = 0; i < imagem.pixels.length; i++) {
      float maiorValor = -1000000000;
      int pixelSelecionado = i;
      for (int j = i; j < imagem.pixels.length; j++) {
        color pix = imagem.pixels[j];
        float valor = 0;
        if (tipo == 'l') {   //light
          valor = brightness(pix);
        } else if (tipo == 'h') {
          valor = hue(pix);
        } else if (tipo == 's') {
          valor = saturation(pix);
        } else if (tipo == 'r') {
          valor = red(pix);
        } else if (tipo == 'g') {
          valor = green(pix);
        } else if (tipo == 'b') {
          valor = blue(pix);
        } else if (tipo == 'c') { 
          valor = pix;  //raw color as int
        } else { 
          println("modo inexistente");
          vai = false;
          return;
        }
        if (valor > maiorValor) {
          pixelSelecionado = j;
          maiorValor = valor;
        }
      }
      // troca o pixel em pixelSelecionado com o i
      color temp = imagem.pixels[i];
      imagem.pixels[i] = imagem.pixels[pixelSelecionado];
      imagem.pixels[pixelSelecionado] = temp;
      imagem.updatePixels();
      //print(".");
    }
    println("");
    println("terminou");
    vai = false;
  }
}

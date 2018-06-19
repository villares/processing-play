
PImage img;  
PImage imgAux;
color cor;

void setup() {
  img = loadImage("moonwalk.jpg");
  imgAux = img.get();
  surface.setSize(img.width, img.height*2);
}

void draw() {
  image(img, 0, 0);
  image(imgAux, 0, img.height);
  img.loadPixels();
  imgAux.loadPixels();


  noStroke();
  cor = get(mouseX, mouseY);
  fill(cor);
  ellipse(mouseX, mouseY, 100, 100);
  float R = red(cor);
  float G = green(cor);
  float B = blue(cor);
  fill(255, 0, 0);
  rect(mouseX, mouseY, R, 10);
  fill(0, 255, 0);
  rect(mouseX, mouseY+10, G, 10);
  fill(0, 0, 255);
  rect(mouseX, mouseY+20, B, 10);
  //println(R, G, B, cor);
}

void mousePressed() {
  byte[] dados = loadBytes("moonwalk.jpg"); 

  for (int i=0; i<100; i++){
  int loc = (int)random(dados.length);
  dados[loc] = (byte)random(127);
  }
  saveBytes("lua.jpg", dados);
  imgAux = loadImage("lua.jpg");
}


void keyPressed() {
  println("começando!");
  for (int i = 0; i < img.pixels.length; i++) {
    float maiorValor = -1;
    int pixelSelecionado = i;
    for (int j = i; j < img.pixels.length; j++) {
      color pix = img.pixels[j];
      float B = blue(pix);
      if (B > maiorValor) {
        pixelSelecionado = j;
        maiorValor = B;
        print(" "+str(maiorValor));
      }
    }
    color temp = img.pixels[i];
    img.pixels[i] = img.pixels[pixelSelecionado];
    img.pixels[pixelSelecionado] = temp;
  }
  img.updatePixels();
}
void settings() {  // settings() é uma espécie de pré-setup
  //size(100, 100);  
  fullScreen(1);
}

void setup() {
  SegundaJanela sj = new SegundaJanela();   // cria um "segundo sketch"
  String[] configuracao = {"Outra Janela"}; // ele precisa de um array de Strings
  PApplet.runSketch(configuracao, sj);      // poe ele pra rodar
}

void draw() {
  background(0);
  ellipse(mouseX, mouseY, 10, 10);
}     

class SegundaJanela extends PApplet {  // definição do segundo sketch

  void settings() {  // para poder usar o size novamente... não rola no setup()
    size(200, 100);  // com dois monitores experimente fullScreen(2);
  }

  void draw() {      // este é o draw pra a segunda janela
    background(255);
    fill(0);
    ellipse(mouseX, mouseY, 10, 10);
  }
}

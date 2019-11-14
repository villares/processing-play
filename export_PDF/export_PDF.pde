import processing.pdf.*;

boolean salvarPDF = false;

void setup() {
  size(400, 400);
}

void draw() {
  // inicio da gravação do PDF
  if (salvarPDF) {
    beginRecord(PDF, "saida.pdf");
  }
  // aqui vai o seu desenho
  rect(100, 100, 200, 100);

  // fim da gravação do PDF
  if (salvarPDF) {
    endRecord();
    print("PDF salvo");
    salvarPDF = false;
  }
}

void keyPressed() {
  if (key == 'p') {
    salvarPDF = true;
  }
}

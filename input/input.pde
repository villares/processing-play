void setup(){
  size(200, 200);
 
}

void draw(){
  if (keyPressed && keyCode == SHIFT) {
    strokeWeight(5);
    stroke(255);
  } else {
    strokeWeight(1);
    stroke(0);
  }

  if (mousePressed) {                        // Se o mouse estiver pressionado
     line(pmouseX, pmouseY, mouseX, mouseY); // Então desenha uma linha da posição anterior do mouse até a atual
  }                                          // termina o bloco (repare que no faz nada se o mouse estiver solto)
}

void keyPressed(){    // Esta função executa uma vez quando uma tecla é pressionada
  if (key == 'a') {   // Se a tecla do caractere 'a' foi a última pressionada
    background(200);  // Apague a tela com um fundo cinza (só executa sob as condições acima)
  }
  if (keyCode == DOWN) {          // Se a tecla SHIFT foi precionada
    saveFrame("imagem-####.png");    // salve a imagem da tela de pintura em um arquivo PNG 
    println("salvo o frame " + frameCount); 
  }  
}
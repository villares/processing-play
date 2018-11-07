

void setup(){
  size(800,400);
}

void olho(int dx, int dy, int tamanho){
  noStroke();
  fill(255); //branco
  ellipse(dx,dy,tamanho*2,tamanho); //ellipse na pos dx,dy
  fill(random(256), random(256), random(256)); //preto
  ellipse(dx,dy,int(tamanho*.9),int(tamanho*.9)); //círculo
  fill(0);
  ellipse(dx, dy, tamanho*.3, tamanho*.3);
}

void draw(){
  background(0);
  for (int i=0; i < 100; i++){
  olho(int(random(width)),int(random(height)),40); //um olho
  }
  olho(mouseX,mouseY,100); //outro olho
  //olho(mouseX,mouseY,int(random(10,50))); //olho na ponta do mouse
  noLoop();
}

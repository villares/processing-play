

void setup(){
  size(800,400);
}

void olho(int dx, int dy, int tamanho){
  noStroke();
  fill(255); //branco
  ellipse(dx,dy,tamanho*2,tamanho); //ellipse na pos dx,dy
  fill(0); //preto
  ellipse(dx,dy,int(tamanho*.9),int(tamanho*.9)); //círculo
}

void draw(){
  olho(100,100,40); //um olho
  olho(120,200,100); //outro olho
  //olho(mouseX,mouseY,int(random(10,50))); //olho na ponta do mouse
}

void setup(){
  size(500, 500);
  noStroke();
}


void draw(){
 color cor = color(random(256),random(256),random(256));
 fill(cor);
 ellipse(mouseX, mouseY, 20, 20); 
}
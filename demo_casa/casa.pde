void casa(float x, float y,
          float larg, float altura,
          color cor) {
  fill(cor);
  rect(x, y, larg, altura);
  fill(random(100,255),0,0);
  triangle(x, y, 
           x+larg, y, 
           x+larg/2, y-altura/2);
  fill(255);         
  rect(x+larg/3, y+altura/2, larg/3, altura/2); 
}
void setup() {
  size(300, 600);
  frameRate(1);
}

void draw() {
  stroke(200, 35);
  strokeWeight(int(random(12, 20)));
  fill(200);
  ellipse(width*.7, height*.2,  int(random(35,40)),  int(random(35,40)));
  noStroke();
  fill(0,10);
  rect(0,0,width,height);
  fill(255, 75);
  float horz = random(300,height);
  rect(0,horz,width,height/2);
  casa(random(width-50), random(300, height-50),
       50, 50, color(0,random(100,200),0));  // x, y, largura, altura, cor
  casa(random(width), random(300, height),
       30, 60, color(0,random(100,200),random(100,200)));
  casa(random(width), random(300, height),
       40, 30, color(random(100,200),random(100,200),0));
}
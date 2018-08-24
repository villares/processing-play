// ½[(x1 y2 - x2 y1)  + (x2 y3 - x3 y2) + . . . (xn-1 yn - xn yn-1)]

PVector[] poly = {
  new PVector(10, 5), 
  new PVector(5, 5), 
  new PVector(20, 20), 
  new PVector(5, 25)

};

void setup() {
  size(300, 300);
  scale(10);
  beginShape();
  for (int i = 0; i < poly.length; i++) {
    vertex(poly[i].x, poly[i].y);
  }
  endShape(CLOSE);
  println(pArea(poly));
}



float pArea(PVector p[])
{ 
  float area=0;
  for (int i = 0; i < p.length; i++) {
    int i1 = (i + 1) % p.length;
    area += (p[i].y + p[i1].y) * (p[i1].x - p[i].x) / 2.0;
  }
  return abs(area);
}

void setup() {
  size(400, 400);
  PVector[] p = {new PVector(10, 10, 0), 
                new PVector(300, 30, 0), 
                new PVector(300, 200, 0), 
                new PVector(40, 300, 0)
              };
  hatch_points(p, 18, 0);
}

void hatch_points(PVector[] points, int divisions, int sides) {
  for (int s = 0; s <= sides; s++) {
    PVector a = points[s]; 
    PVector b =  points[s+1];
    PVector c = points[s+2]; 
    PVector d = points[s+3];
    for (int i = 0; i < divisions; i++) {
      float n = float(divisions);
      PVector s0 = PVector.lerp(a, b, i/n);
      PVector s1 = PVector.lerp(d, c, i/n);
      line(s0.x, s0.y, s1.x, s1.y);
    }
  }
}

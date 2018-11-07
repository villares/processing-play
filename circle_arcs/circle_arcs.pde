void setup() {
  circle_arc(5, 5, 25, 0, HALF_PI);
  half_circle(60, 5, 25, 0);
  quarter_circle(95, 95, 25, 2);
}

void circle_arc(float x, float y, float radius, float start_ang, float sweep_ang) {
  arc(x, y, radius * 2, radius * 2, start_ang, start_ang + sweep_ang);
}   

void quarter_circle(float x, float y, float radius, int quadrant) {
  circle_arc(x, y, radius, quadrant * HALF_PI, HALF_PI);
}

void half_circle(float x, float y, float radius, int quadrant) {
  circle_arc(x, y, radius, quadrant * HALF_PI, PI);
}

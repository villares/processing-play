import processing.svg.*;
PGraphics pgDrawing;
PShape bg;
 
void setup() {
  size(400, 400);
  background(255);
 
  pgDrawing = createGraphics(400, 400, SVG, "test.svg");
  pgDrawing.beginDraw();
  pgDrawing.background(255);
  pgDrawing.stroke(0);
  pgDrawing.strokeWeight(4);
  pgDrawing.rect (10, 10, 70, 50, 10);
  pgDrawing.endDraw();
  pgDrawing.dispose();
  bg = loadShape("test.svg");
}
 
void draw() {
  shape(bg, 0, 0);
  noLoop();
}
 
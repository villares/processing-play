// from https://discourse.processing.org/t/how-to-remove-title-bar/7537/8

import java.awt.*;

int gMouseX = 0, gMouseY = 0;  // g for global
float screenPosX, screenPosY, factorX, factorY; // Movement factor

void settings() {
  fullScreen();
}
void setup() {
  surface.setSize(400, 200);
  screenPosX = (displayWidth - width)/2;     // Positioning window in the center
  screenPosY = (displayHeight - height)/2;
}
void draw () {  
  background(30);

  textAlign(CENTER, CENTER);
  textSize(height*0.1);
  text("Ethiopia", width/2, height/2);

  globally ();
}
void globally () {
  surface.setLocation((int) screenPosX, (int) screenPosY);
  
  Point location = MouseInfo.getPointerInfo().getLocation();
  gMouseX = (int) location.getX();  // global mouse position along X
  gMouseY = (int) location.getY();  // global mouse position along Y
}
void mousePressed() {
  factorX = mouseX;
  factorY = mouseY;
}
void mouseDragged() {
  screenPosX = MouseInfo.getPointerInfo().getLocation().x - factorX;
  screenPosY = MouseInfo.getPointerInfo().getLocation().y - factorY;
}

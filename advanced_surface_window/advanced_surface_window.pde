// code from: https://discourse.processing.org/t/is-it-possible-to-not-have-the-generic-windows-close-buttons-and-make-your-own-close-button/2013/6?u=villares
// by @DOngKingKong0 https://discourse.processing.org/u/DongKingKong0/

import processing.awt.PSurfaceAWT;
import java.awt.MouseInfo;
import java.awt.Point;

boolean isInFullscreen;
boolean dragging;
int dragX, dragY;
Button hide, full, close;
PSurfaceAWT awtSurface;
PSurfaceAWT.SmoothCanvas smoothCanvas;

void setup(){
  size(800, 600);
  noStroke();
  
  awtSurface = (PSurfaceAWT)surface;
  smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();
  smoothCanvas.getFrame().removeNotify();
  smoothCanvas.getFrame().setUndecorated(true);// Hide the window border
  smoothCanvas.getFrame().setLocation(100, 100);// Move the window
  smoothCanvas.getFrame().addNotify();
  surface.setResizable(true);
  
  // Menu Buttons
  hide = new Button(width - 115, -5, 40, 25, color(100), 5);
  full = new Button(width - 80, -5, 40, 25, color(150), 5);
  close = new Button(width - 45, -5, 50, 25, color(200, 0, 0), 5);
}

void draw(){
  background(200);
  // Draw Menu Bar
  fill(225);
  rect(0, 0, width, 20);
  hide.display();
  full.display();
  close.display();
}

void mousePressed(){
  if(hide.isMouseOver()){
    smoothCanvas.getFrame().toBack();// Hide window
  }
  if(full.isMouseOver()){
    isInFullscreen = !isInFullscreen;
    if(isInFullscreen){
      smoothCanvas.getFrame().setLocation(0, 0);
      smoothCanvas.getFrame().setSize(displayWidth, displayHeight);
    }else{
      smoothCanvas.getFrame().setLocation(100, 100);
      smoothCanvas.getFrame().setSize(800, 600);
    }
  }
  if(close.isMouseOver()){
    exit();// Close window
  }
  // Drag window
  if(mouseY < 20){
    dragging = true;
    dragX = mouseX;
    dragY = mouseY;
  }
}

void mouseDragged(){
  if(dragging){
    // Get mouse position and move the window
    Point mouse = MouseInfo.getPointerInfo().getLocation();
    smoothCanvas.getFrame().setLocation(mouse.x - dragX, mouse.y - dragY);
  }
}

void mouseReleased(){
  dragging = false;
}

// Menu Button Class
class Button{
  int xpos, ypos;
  int sizeX, sizeY;
  color buttonColor;
  int borderRadius;
  
  Button(int x, int y, int sx, int sy, color c, int br){
    xpos = x;
    ypos = y;
    sizeX = sx;
    sizeY = sy;
    buttonColor = c;
    borderRadius = br;
  }
  
  void display(){
    fill(buttonColor);
    rect(xpos, ypos, sizeX, sizeY, borderRadius);
  }
  
  boolean isMouseOver(){
    if(mouseX > xpos && mouseX < xpos + sizeX && mouseY > ypos && mouseY < sizeY){
      return true;
    }
    return false;
  }
}

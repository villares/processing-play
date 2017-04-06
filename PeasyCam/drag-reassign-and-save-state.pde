/* PeasyCam by Jonathan Feinberg http://mrfeinberg.com/peasycam/
 * provides a dead-simple mouse-driven camera for Processing.
 * This example shows how to reassign drag handlers and save a camera state
 */

import peasy.*;

PeasyCam cam;
CameraState saved_cam; // used to save a camera state

void setup() {
  size(200, 200, P3D);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  // Reassign some drag handlers  
  PeasyDragHandler orbitDH = cam.getRotateDragHandler();  // get the rotate Handler
  cam.setCenterDragHandler(orbitDH);                     // set it to the Center/Wheel click/drag
  PeasyDragHandler panDH = cam.getPanDragHandler();     // get the rotate Handler
  cam.setRightDragHandler(panDH);                      // set left-button mouse drag
  cam.setLeftDragHandler(null);                       // disable right-drag
}
void draw() {
  background(0);
  fill(255, 0, 0);
  box(30);
  pushMatrix();
  translate(0, 0, 20);
  fill(0, 0, 255);
  box(5);
  popMatrix();
}

void keyPressed() {
  if (key == 'r' || key == 'R') { 
    cam.reset();  // reset original camera state
  }
  if (key == 's' || key == 'S') {
    saved_cam = cam.getState();  // save a camera state
  } 
  if (key == 'l' || key == 'L') {
    if (saved_cam != null) cam.setState(saved_cam);  // load a camera state (if one was previously saved)
  }
}

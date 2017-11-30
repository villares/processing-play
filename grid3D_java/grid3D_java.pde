/*
 A funny wobbling 3D grid - by Alexandre B A Villares (abav.lugaralgum.com)
 1. install Processing (processing.org)
 3. install PeasyCam library under Sketch...>Import Libray...>Add Library...
 */

import peasy.* ; // Drag the mouse to orbit!
PeasyCam cam;

float ang = 0;
int bSize = 5; // bSize <= box_size < bSize * 2
int bRange = 10; 
int numberOfBoxes = (int)pow(bRange, 3);
float sSize = 10;   // Controls the spacing of the grid
float slide = 5;    // Changes the sliding behaviour
float speed = 0.01; // Increments ang
color[] colors;
float[] sizes;

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 200);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(200);
  colors = new color[numberOfBoxes];
  sizes = new float[numberOfBoxes];
  myGrid(false);
}
void draw() {
  background(0);
  myGrid(true);
  ang += speed;
}
void myGrid(boolean plot) {
  int c = 0;
  for (int i = 0; i < bRange; i++) {
    for (int j = 0; j < bRange; j++) {
      for (int k = 0; k < bRange; k++) {
        if (plot) { // Draw
          fill(colors[c]);
          myBox(i * sSize * sin(ang + i * slide), 
            j * sSize * sin(ang + j * slide), 
            k * sSize * sin(ang + k * slide), 
            sizes[c]);
        } else {    // Setup
          int R = (int)map(i, 0, bRange, 0, 255);
          int G = (int)map(j, 0, bRange, 0, 255);
          int B = (int)map(k, 0, bRange, 0, 255);          
          colors[c]= color(R, G, B);
          sizes[c] = bSize + random(bSize);
        }
        c++;
      }
    }
  }
}

void myBox(float x, float y, float z, float s) {
  pushMatrix();
  translate(x, y, z);
  box(s);
  popMatrix();
}

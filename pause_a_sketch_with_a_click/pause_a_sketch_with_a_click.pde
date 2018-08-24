boolean paused = false;

void setup() {
  size (100, 100);
}

void draw() {
  background(0);
  text(str(frameCount), 5, 15);
}

void mouseClicked() {
  paused = !paused;
  if (paused) {
    noLoop();
  } else {
    loop();
  }
}

Star stars[] = new Star[100];

void setup() {
  size(600, 600);
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
}

void draw() {
  background(0);
  translate(width/2, height/2);
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
}

class Star {
  float speed = 5;
  float x = random(-width/2, width/2);
  float y = random(-height/2, height/2);
  float z = random(width/2);
  float pz = z;

  void update() {
    z = z - speed;
    if (z < 0) {
      x = random(-width/2, width/2);
      y = random(-height/2, height/2);
      z = random(width/2);
      pz = z;
    }
  }

  void show() {
    fill(255);
    noStroke();
    float sx = map(x/z, 0, 1, 0, width/2);
    float sy = map(y/z, 0, 1, 0, height/2);
    float r = map(z, 0, width/2, 6, 0);
    ellipse(sx, sy, r, r);
    float px = map(x/pz, 0, 1, 0, width/2);
    float py = map(y/pz, 0, 1, 0, height/2);
    pz = z;
    stroke(255);
    line(px, py, sx, sy);
  }
}

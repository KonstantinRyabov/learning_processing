ArrayList<Part> parts = new ArrayList<>();
float r = 20;
float zoff = 0;
float inc = 0.1;

void setup() {
  size(400, 400, P3D);
  for (int i = -1; i < 10; i++) {
    for (int j = -1; j < 10; j++) {
      parts.add(new Part(i*r, j*r, r));
    }
  }
}


void draw() {
  background(255);
  translate(width/2, height/2);
  rotateX(0.3);
  float xoff = 0;
  for (Part m : parts) {
    float yoff = 0;
    for (Part item : parts) {
      float deep = map(noise(xoff, yoff, zoff), 0, 1, 0, 700);
      yoff += inc;
      item.setDeep(deep);
      item.show();
    }
    xoff += inc;
    zoff += 0.0001;
  }
}

class Part {
  float w;
  float h;
  float r;
  float deep = 10;
  Part(float w_, float h_, float r_) {
    w = w_;
    h = h_;
    r = r_;
  }

  void setDeep(float deep_) {
    deep = deep_;
  }
  void show() {
    pushMatrix();
    translate(w, h);
    float col = map(deep, 0, 700, 255, 0);
    fill(col);
    noStroke();
    box(r, r, deep);
    popMatrix();
  }
}

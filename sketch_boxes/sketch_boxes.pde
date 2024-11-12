float a = 0;
ArrayList<Box> sponge;
void setup() {
  size(400, 400, P3D);
  sponge = new ArrayList<Box>();
  Box box = new Box(0, 0, 0, 200);
  sponge.add(box);

  ArrayList next = new ArrayList<Box>();
  for (Box b : sponge) {
    ArrayList<Box> newBoxes = b.generate();
    next.addAll(newBoxes);
  }
  sponge = next;
}

void draw() {
  background(51);
  stroke(255);
  noFill();
  translate(width/2, height/2);
  rotateX(a);
  for (Box b : sponge) {
    b.show();
  }
  a += 0.01;
}

class Box {
  float r;
  PVector pos;

  Box(float x, float y, float z, float r_) {
    pos = new PVector(x, y, z);
    r = r_;
  }

  ArrayList<Box> generate() {
    ArrayList<Box> boxes = new ArrayList<Box>();
    for (float x = -1; x < 2; x++) {
      for (float y = -1; y < 2; y++) {
        for (float z = -1; z < 2; z ++) {
          float new_r = r/3;
          Box box = new Box(pos.x + x * new_r, pos.y + y * new_r, pos.z + z * new_r, new_r);
          boxes.add(box);
        }
      }
    }
    return boxes;
  }
  
  void show(){
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    stroke(255);
    box(r);
    popMatrix();
  }
}

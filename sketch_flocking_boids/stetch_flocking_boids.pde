class Vehicle {
  PVector position;
  PVector velocity = new PVector(0, 0);
  PVector accleration = new PVector(0, 0);
  float r = 6;
  float maxSpeed = 40;
  float maxForce = 0.5;

  Vehicle(float x, float y) {
    position = new PVector(x, y);
  }

  void applyForce(PVector force) {
    this.accleration.add(force);
  }

  void update() {
    this.velocity.add(this.accleration);
    this.position.add(this.velocity);
    this.accleration.mult(0);
  }

  void arrival(PVector target) {
    PVector desired = PVector.sub(target, position);
    float d = desired.mag();
    if (d < 100) {
      float m = map(d, 0, 100, 0, maxSpeed);
      desired.setMag(m);
    } else {
      desired.setMag(maxSpeed);
    }
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    this.applyForce(steer);
  }

  void seeking(FlowFields flow) {
    PVector desired = flow.lookup(this.position);
    desired.limit(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    this.applyForce(steer);
  }

  void borders() {
    if (this.position.x < -this.r) this.position.x = width + this.r;
    if (this.position.y < -this.r) this.position.y = height + this.r;
    if (this.position.x > width + this.r) this.position.x = -this.r;
    if (this.position.y > height + this.r) this.position.y = -this.r;
  }

  void show() {
    float angle = this.velocity.heading();
    fill(125);
    stroke(255);
    pushMatrix();
    translate(this.position.x, this.position.y);
    rotate(angle);
    beginShape();
    vertex(2*r, 0);
    vertex(-2*r, -r);
    vertex(-2*r, r);
    endShape();
    popMatrix();
  }
}
class FlowFields {
  float r;
  PVector[][] arr;
  int cols;
  int rows;
  FlowFields(float _r) {
    r = _r;
    int i = int(width / r);
    int j = int(height / r);
    arr = new PVector [i][j];
    cols = arr.length;
    rows = arr[0].length;
    init();
  }

  void init() {
    float xoff = 0;
    for (int i = 0; i < this.cols; i++) {
      float yoff = 0;
      for (int j = 0; j < this.rows; j++) {
        float angle = map(noise(xoff, yoff), 0, 1, 0, TWO_PI);
        arr[i][j] = PVector.fromAngle(angle);
        yoff += 0.1;
      }
      xoff += 0.1;
    }
  }
  void show() {
    for (int i = 0; i < this.cols; i++) {
      for (int j = 0; j < this.rows; j++) {
        int w = width / this.cols;
        int h = height / this.rows;
        PVector v = this.arr[i][j].copy();
        v.setMag(w * 0.5);
        int x = i * w + w / 2;
        int y = j * h + h / 2;
        strokeWeight(1);
        line(x, y, x + v.x, y + v.y);
      }
    }
  }

  PVector lookup(PVector position) {
    int column = int(constrain(floor(position.x / this.r), 0, this.arr.length - 1));
    int row = int(constrain(floor(position.y / this.r), 0, this.arr[0].length - 1));
    return this.arr[column][row].copy();
  }
}

FlowFields flow;
Vehicle[] vehicles = new Vehicle[30];
void setup() {
  size(1024, 1024);
  flow = new FlowFields(20);

  for (int i = 0; i < vehicles.length; i++) {
    vehicles[i] = new Vehicle(random(width), random(height));
  }
}

void draw() {
  background(0);
  fill(127);
  stroke(255);

  for (int i = 0; i < vehicles.length; i++) {
    vehicles[i].seeking(flow);
    vehicles[i].update();
    vehicles[i].borders();
    vehicles[i].show();
  }
  
 flow.show();
}

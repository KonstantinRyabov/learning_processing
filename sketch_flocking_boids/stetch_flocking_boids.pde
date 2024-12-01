class Vehicle {
  PVector position;
  PVector velocity = new PVector(0, 0);
  PVector accleration = new PVector(0, 0);
  float r = 6;
  float maxSpeed = 3;
  float maxForce = 0.4;

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

  void seeking(PVector target) {
    PVector desired = PVector.sub(target, position);
    desired.limit(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    this.applyForce(steer);
  }

  void show() {
    float angle = this.velocity.heading();
    fill(125);
    stroke(0);
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
Vehicle vehicle;
void setup() {
  size(640, 640);
  vehicle = new Vehicle(width/2, height/2);
}

void draw() {
  background(255);
  PVector target = new PVector(mouseX, mouseY);
  fill(127);
  stroke(0);
  circle(mouseX, mouseY, 20);
  vehicle.seeking(target);
  vehicle.update();
  vehicle.show();
}

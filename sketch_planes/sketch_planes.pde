class Vehicle {
  float x;
  float y;
  PVector position = new PVector(0, 0);
  PVector velocity = new PVector(0, 0);
  PVector acceleration = new PVector(0, 0);
  float r = 6.0;
  float maxspeed = 8;
  float maxforce = 0.2;

  Vehicle(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    velocity = velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void seek(PVector target) {
    PVector desired = target.sub(position);
    desired.setMag(maxspeed);
    PVector steer = desired.sub(desired, velocity);
    steer.limit(maxforce);
    this.applyForce(steer);
  }

  void show() {
    float angle = velocity.heading();
    fill(127);
    stroke(0);
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    beginShape();
    vertex(r * 2, 0);
    vertex(r * -2, -1 * r);
    vertex(r * -2, r);
    endShape();
    popMatrix();
  }
}

Vehicle vehicle;
void setup() {
  size(500, 500);
  vehicle = new Vehicle(width/2, height/2);
}


void draw() {
  background(255);
  PVector mouse = new PVector(mouseX, mouseY);
  fill(127);
  stroke(0);
  circle(mouse.x, mouse.y, 28);
  
  vehicle.seek(mouse);
  vehicle.update();
  vehicle.show();
  
}

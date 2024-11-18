class Move {
  PVector position;
  PVector velocity = new PVector(0, 0);
  PVector accleration = new PVector(0, 0);
  float mass;
  Move(float x, float y, float mass_) {
    position = new PVector(x, y);
    mass = mass_;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    accleration.add(f);
  }
  void update() {
    velocity.add(accleration);
    position.add(velocity);
    accleration.mult(0);
  }
  void show() {
    stroke(0);
    fill(127);
    circle(position.x, position.y, mass*16);
  }

  void checkEdge() {
    if (position.y >= height) {
      position.y = height;
      velocity.mult(-1);
    }
  }
}

Move mv = new Move(width/2, 30, 20);
void setup() {
  size(500, 500);
}


void draw() {
  background(255);
  PVector gravity = new PVector(0, 2);
  mv.applyForce(gravity);
  if(mousePressed){
     PVector wind = new PVector(5, 0);
     mv.applyForce(wind);
  }
  mv.update();
  mv.show();
  mv.checkEdge();
}

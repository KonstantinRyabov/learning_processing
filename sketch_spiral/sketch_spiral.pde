class Move {
  float theta = 0;
  float r = height *0.45;
  PVector pos;

  void update() {
    pos = PVector.fromAngle(theta);
    pos.mult(r);
    theta = theta + 0.02;
    r = r + 0.1;
  }
  void show() {
    stroke(0);
    fill(127);
    translate(width / 2, height / 2);
    line(0, 0, pos.x, pos.y);
    circle(pos.x, pos.y, 20);

  }
}


Move move = new Move();
void setup() {
  size(640, 640);
}


void draw() {
  background(255);
  move.update();
  move.show();
}

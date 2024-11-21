

class Attract {
  PVector position;
  PVector velocity = new PVector(0, 0);
  PVector accleration = new PVector(0, 0);
  float mass;
  float G = 0.1;
  Attract(float x, float y, float mass_) {
    this.position = new PVector(x, y);
    mass = mass_;
  }

  PVector attracting(Attract att) {
    PVector dis = PVector.sub(this.position, att.position);
    float dis_mag = constrain(dis.mag(), 5, 25);
    float mag =  G * (this.mass * att.mass)/dis_mag;
    return dis.setMag(mag);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    this.accleration.add(f);
  }
  void update() {
    this.velocity.add(this.accleration);
    this.position.add(this.velocity);
    this.accleration.mult(0);
  }
  void show() {
    stroke(0);
    fill(127);
    circle(this.position.x, this.position.y, mass*13);
  }
}

Attract atts[] = new Attract[10];
void setup() {
  size(640, 640);
  for (int i = 0; i < atts.length; i++) {
    float mass = random(1,2);
    atts[i] = new Attract(random(width), random(height), mass);
  }
}


void draw() {
  background(255);
  for (int i = 0; i < atts.length; i++) {
    for (int j = 0; j < atts.length; j++) {
      if (i != j) {
        PVector grav = atts[i].attracting(atts[j]);
        atts[j].applyForce(grav);
      }
    }
    atts[i].update();
    atts[i].show();
  }
}

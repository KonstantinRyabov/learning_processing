

class Attract {
  PVector position;
  PVector velocity = new PVector(0, 0);
  PVector accleration = new PVector(0, 0);
  float angle = 0;
  float angleVelocity = 0;
  float angleAccleration = 0;
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
    this.angleAccleration = accleration.x/10;
    this.position.add(this.velocity);
    this.accleration.mult(0);
    this.angleVelocity = this.angleVelocity + this.angleAccleration;
    this.angleVelocity = constrain(this.angleVelocity, -0.1, 0.1);
    this.angle = this.angle + this.angleVelocity;
  }
  void show() {
    stroke(0);
    fill(127);
    float r = mass*13;
    pushMatrix();
    translate(this.position.x, this.position.y);
    rotate(this.angle);
    circle(0, 0, r);
    line(0, 0, r/2, 0);
    popMatrix();
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

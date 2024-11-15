Drop drop[] = new Drop[100];

void setup() {
  size(500, 500);
  for(int i = 0; i < 100; i++){
      drop[i] = new Drop();
  }
}

void draw() {
  background(255);
  for(int i = 0; i < 100; i++){
      drop[i].fall();
      drop[i].show();
  }
}

class Drop {
  float x = random(10, 490);
  float y = random(-10, -30);
  float z = random(0,20);
  float speed = random(4, 10);
  float len = map(speed, 4, 10, 1, 7);

  void fall() {
    y = y+speed;
    if(y > 500){
      y = random(-10, -30);
      speed = random(4, 10);
    }
  }

  void show() {
    float thick = map(z, 0, 20, 2, 1);
    strokeWeight(thick);
    stroke(0);
    line(x,y,x,y+len);
  }
}

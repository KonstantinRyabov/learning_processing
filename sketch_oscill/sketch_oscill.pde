class Oscill{
PVector angel = new PVector(0,0);
PVector angelVelocity = new PVector(0, 0);
PVector ampl = new PVector(random(20, width/2), random(20, height/2));
PVector angelAcc = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
void update(){
  angelVelocity.add(angelAcc);
  angel.add(angelVelocity);
  angelAcc.mult(0);
}

void show(){
  float x = sin(angel.x) * ampl.x;
  float y = sin(angel.y) * ampl.y;
  pushMatrix();
  translate(width/2, height/2);
  fill(127);
  line(0,0,x,y);
  circle(x,y,25);
  popMatrix();
 }
}
Oscill oscill[] = new Oscill[5];
void setup(){
  for(int i = 0; i < oscill.length; i++){
      oscill[i] = new Oscill();
  }
  size(640, 240);
}

void draw(){
  background(255);
    for(int i = 0; i < oscill.length; i++){
      oscill[i].update();
      oscill[i].show();
  }
}

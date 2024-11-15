import peasy.*;

float a = 10;
float p = 28;
float b = 8.0/3.0;
float dt = 0.01;

float x = 0.01;
float y = 0;
float z = 0;

float dx = 0;
float dy = 0;
float dz = 0;
ArrayList<PVector>points = new ArrayList<>();
PeasyCam cam;

void setup() {
   size(500, 500, P3D);
  cam = new PeasyCam(this, 500);
}

void draw() {
  background(0);
  dx = a*(y - x) * dt;
  dy = (x*(p - z) - y) * dt;
  dz = (x*y - b*z) * dt;
  x = x + dx;
  y = y + dy;
  z = z + dz;
  PVector vec = new PVector();
  vec.x = x;
  vec.y = y;
  vec.z = z;
  points.add(vec);
  //translate(width/2, height/2);
  translate(0, 0, -80);
  scale(5);
  stroke(255);
  noFill();
  beginShape();
  for(PVector point: points){
    vertex(point.x, point.y, point.z);
  }
  endShape();
}

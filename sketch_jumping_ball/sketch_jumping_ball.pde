class Liquid{
  float x;
  float y;
  float w;
  float h;
 Liquid(float x_, float y_, float w_, float h_){
   this.x = x_;
   this.y = y_;
   this.w = w_;
   this.h = h_;
 }
 
 void show(){
   noStroke();
   fill(175);
   rect(x,y,w,h);
 }
 
 PVector calcDrag(Move mv){
   float speed = mv.velocity.mag();
   float dragMag = speed * speed *0.1;
   PVector drag = mv.velocity.copy();
   drag.setMag(dragMag);
   drag.mult(-1);
   
   return drag;
 }
 
 boolean contains(Move mv){
   PVector pos = mv.position;
   if(pos.y > this.y){
      return true;
   }
   return false;
 }

}


class Move {
  PVector position;
  PVector velocity = new PVector(0, 0);
  PVector accleration = new PVector(0, 0);
  float mass;
  Move(float x, float y, float mass_) {
    this.position = new PVector(x, y);
    mass = mass_;
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

  void checkEdge() {
    if (position.y > height) {
      position.y = height;
      velocity.y = velocity.y * -1;
    } 
    
    if (position.x > width){
      position.x = width;
      velocity.x = velocity.x * -1;
    } else if (position.x < 0){
      position.x = 0;
      velocity.x = velocity.x * -1;
    }
  }
}

Move mv[] = new Move[9];
Liquid lic;
void setup() {
  lic = new Liquid(0, height/2, width, height/2);
  size(640, 440);
  for(int i = 1; i < 9; i++){
    float mass = random(1, 5);
     mv[i] = new Move(40 + i * 70, 0, mass);
  }
}


void draw() {
  background(255);
  lic.show();
  for(int i = 1; i < 9; i++){ 
    PVector gravity = new PVector(0, 2);
    gravity.mult(mv[i].mass * 0.1);
    mv[i].applyForce(gravity);
    if(mousePressed){
       PVector wind = new PVector(5, 0);
       mv[i].applyForce(wind);
    }
  
    PVector drag = new PVector(0, 0);
    if(lic.contains(mv[i])){
      drag = lic.calcDrag(mv[i]);
    }
    mv[i].applyForce(drag);
    mv[i].update();
    mv[i].show();
    mv[i].checkEdge();
  }
}

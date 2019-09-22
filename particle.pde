class particle {
  boolean isAttached;
  PVector pos;
  PVector vel;
  int radius = 3;
  float vMag;
  color c = color(255);
  particle() {
    isAttached = false;
    pos = new PVector(random(10, width-10), random(10, height-10));
    vel = new PVector(random(-5, 5), random(-5, 5));
    vMag = vel.mag();
  }
  particle(boolean isCenter) {
    isAttached = true;
    pos = new PVector(width/2, height/2);
    vel = new PVector(0,0);
  }
    particle(int x, int y){
    isAttached = true;
    pos = new PVector(x, y);
    vel = new PVector(0,0);
    this.c = c;
    
    show();
  }
  particle(int x, int y, color c){
    isAttached = true;
    pos = new PVector(x, y);
    vel = new PVector(0,0);
    this.c = c;
    
    show();
  }
  void show() {
    //ellipse(pos.x, pos.y, radius, radius);
    fill(c);
    if (pos.x < 4 || pos.x > width-4) {
      vel.x = -vel.x;
    }
    if (pos.y < 4 || pos.y > height-4) {
      vel.y = -vel.y;
    }
    if(!isAttached){
      pos.add(vel);
      vel.x += random(-5, 5);
      vel.y += random(-5, 5);
    }else{
      //ellipse(pos.x, pos.y, radius, radius);
    }
    vel.normalize().mult(3);
}
void drawCircle(){
  stroke(c);
  ellipse(pos.x, pos.y, radius, radius);
}

  boolean isColliding(PVector pos2) {
    if (dist(pos.x, pos.y, pos2.x, pos2.y) < 2*radius+1) {
      vel = new PVector(0, 0); 
      isAttached = true;
      return true; 
    }
    return false;
  }
  void calculateGravity(int mass){
    float grav = mass/((pos.x-width/2)*(pos.x-width/2) + (pos.y-height/2)*(pos.y-height/2));
    vel.add(new PVector(width/2-pos.x, height/2-pos.y).mult(grav)).normalize().mult(vMag);
  }
}

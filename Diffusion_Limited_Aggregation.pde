ArrayList<particle> activeParticle;
ArrayList<particle> stationaryParticle;
ArrayList<particle> moveList;
int stationaryArraySize;
int t = 0;
int growthRate = 5;
Table dataEntries;
void setup() {
  size(800,500);
  activeParticle = new ArrayList<particle>();
  stationaryParticle = new ArrayList<particle>();
  moveList = new ArrayList<particle>();
  dataEntries = new Table();
  dataEntries.addColumn("time");
  dataEntries.addColumn("live particles");

  for (int i = 0; i < 3000; i++) {
    activeParticle.add(new particle());
  }
  //particle origin = new particle(true);
  //stationaryParticle.add(origin);
  background(0);
  noStroke();
  stroke(255);
}

void draw() {

  for (particle s : stationaryParticle) {
    s.show();
  }
  stationaryArraySize = stationaryParticle.size();
  for (particle p : activeParticle) {
    p.show(); 
    //p.calculateGravity(stationaryArraySize);
    for (particle s : stationaryParticle) {
      if (p.isColliding(s.pos)) {
        moveList.add(p);
        p.c = s.c;
        strokeWeight(3);
        stroke(s.c);
        line(p.pos.x, p.pos.y, s.pos.x, s.pos.y);
        strokeWeight(1);
      }
    }
  }

  for (particle m : moveList) {
    activeParticle.remove(m);
    if (!stationaryParticle.contains(m))
      stationaryParticle.add(m);
  }
  moveList.clear();
  if (t%growthRate == 0) {
    println(t +"\t" + activeParticle.size()) ;
    //TableRow newRow = dataEntries.addRow();
    //newRow.setInt("time", t);
    //newRow.setInt("live particles", activeParticle.size());
    //int growth = int(activeParticle.size()*growthRate);
    
      activeParticle.add(new particle());

  }
  t++;
  //saveFrame("video/frame####");
}

void keyPressed() {
  activeParticle.add(new particle());
  if (key == ' ') {
    saveTable(dataEntries, "data/sim4.csv");
    exit();
  }else if(keyCode == UP){
   growthRate++; 
  }else if(keyCode == DOWN && growthRate > 1){
   growthRate--; 
  }else if(key == 'r'){
    stroke(255,0,0);
  }
}
void mouseDragged(){
  particle p;
  if(mouseButton == LEFT){
    p = new particle(mouseX, mouseY, color(255,0,0));
  }else{
    p = new particle(mouseX, mouseY, color(0,0,255));
  }
    
    stationaryParticle.add(p);
    p.drawCircle();
}

String code = "Picture of code"; //Along with comments

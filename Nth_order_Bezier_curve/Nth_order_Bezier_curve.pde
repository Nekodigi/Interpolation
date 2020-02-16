ArrayList<PVector> B = new ArrayList<PVector>();

void setup(){
  //size(500, 500);
  fullScreen();
}

void keyPressed(){
  if(key == 'r'){
    B = new ArrayList<PVector>();
  }
}

void mousePressed(){
  B.add(new PVector(mouseX, mouseY));
}

void draw(){
  background(255);
  
  //draw point
  noFill();
  strokeWeight(10);
  strokeJoin(ROUND);
  beginShape();
  for(PVector pos : B){
    ellipse(pos.x, pos.y, 10, 10);
    vertex(pos.x, pos.y);
  }
  endShape();
  //draw result
  strokeWeight(5);
  beginShape();
  for(float t = 0; t < 1; t+= 0.01){
    PVector p = P(t);
    vertex(p.x, p.y);
  }
  endShape();
}
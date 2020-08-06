ArrayList<PVector> P = new ArrayList<PVector>();
int n = 2;//nth order
int m = 0;//num knot(t) count
boolean close = false;

void setup() {
  //size(1000, 500);
  fullScreen();
  strokeWeight(10);
  strokeJoin(ROUND);
}

void keyPressed(){
  if(key == 'r'){
    P = new ArrayList<PVector>();
    m = P.size()+n+1;
  }
  if(key == 'e'){
    close = !close;
  }
  if(keyCode == UP){
    n++;
    m = P.size()+n+1;
  }
  if(keyCode == DOWN){
    n--;
    if(n <= 1){
      n = 1;
    }
    m = P.size()+n+1;
  }
}

void mousePressed(){
  P.add(new PVector(mouseX, mouseY));
  m = P.size()+n+1;
}

void draw() {
  background(255);
  noFill();
  if(P.size() > 0){
    //control point show
    stroke(0, 50);
    beginShape();
    for(PVector p : P){
      vertex(p);
    }
    endShape();
    //curve show
    stroke(0);
    beginShape();
    for (float t = 0; t < 1; t+= 0.01f) {
      vertex(Spline(t, close));
    }
    endShape();
  }
}

void vertex(PVector p){
  vertex(p.x, p.y);
}
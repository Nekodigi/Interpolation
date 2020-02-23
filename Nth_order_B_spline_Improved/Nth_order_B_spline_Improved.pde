ArrayList<PVector> P = new ArrayList<PVector>();
int[] knots;
int DI = 3;//nth orderu

void setup() {
  //size(1000, 500);
  fullScreen();
  strokeWeight(10);
  strokeJoin(ROUND);
}

void keyPressed() {
  if (key == 'r') {
    P = new ArrayList<PVector>();
    knots = SplineKnots(P.size()-1, DI);
  }
  if (keyCode == UP) {
    DI++;
    knots = SplineKnots(P.size()-1, DI);
  }
  if (keyCode == DOWN) {
    DI--;
    if (DI <= 1) {
      DI = 1;
    }
    knots = SplineKnots(P.size()-1, DI);
  }
}

void mousePressed() {
  P.add(new PVector(mouseX, mouseY));
  knots = SplineKnots(P.size()-1, DI);
}

void draw() {
  background(255);
  noFill();
  if (P.size() > 0) {
    //control point show
    stroke(0, 50);
    beginShape();
    for (PVector p : P) {
      vertex(p);
    }
    endShape();
    //curve show
    stroke(0);
    beginShape();
    for (float t = 0; t < (P.size() - 1 - DI + 2); t += 0.01f) {
      vertex(Spline(t));
    }
    endShape();
  }
}

PVector Spline(float t) {//Position at t.
  PVector sum = new PVector();
  PVector p;
  for (int i = 0; i < P.size(); i++) {
    p = P.get(i);
    sum.add(PVector.mult(p, SplineBlend(i, DI, knots, t)));
  }
  return sum;
}

void vertex(PVector p) {
  vertex(p.x, p.y);
}
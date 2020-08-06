//based on these site https://en.wikipedia.org/wiki/B%C3%A9zier_curve
float spacing = 100;//distance between each points
ArrayList<PVector> B = new ArrayList<PVector>();//control points

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
  if(B.size() == 4){
    //calculate evenly spaced points https://www.youtube.com/watch?v=d9k97JemYbM
    float resolution = 1;//to get better points
    float controlNetLength = PVector.dist(B.get(0), B.get(1)) + PVector.dist(B.get(1), B.get(2)) + PVector.dist(B.get(2), B.get(3));
    float estimatedLength = PVector.dist(B.get(0), B.get(3)) + controlNetLength/2;
    int divisions = int(estimatedLength*resolution*10);
    ArrayList<PVector> evenlySpacedPoints = new ArrayList<PVector>();
    PVector previousPoint = B.get(0);
    evenlySpacedPoints.add(previousPoint);
    float dstSinceLastEvenPoint = 0;
    for(float t = 0; t < 1; t+= 1./divisions){
      PVector pointOnCurve = P(t);
      dstSinceLastEvenPoint = PVector.dist(previousPoint, pointOnCurve);
      
      while(dstSinceLastEvenPoint >= spacing){
        float overshootDst = dstSinceLastEvenPoint - spacing;
        PVector newEvenlySpacedPoint = PVector.add(pointOnCurve, PVector.sub(previousPoint, pointOnCurve).setMag(overshootDst));//liner interpolate
        evenlySpacedPoints.add(newEvenlySpacedPoint);
        dstSinceLastEvenPoint = overshootDst;
        previousPoint = newEvenlySpacedPoint.copy();
      }
    }
    evenlySpacedPoints.add(B.get(3));
    //draw result
    strokeWeight(5);
    beginShape();
    for(PVector p : evenlySpacedPoints){
      ellipse(p.x, p.y, 10, 10);
      vertex(p.x, p.y);
    }
    endShape();
  }
}

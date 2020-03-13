int pSize = 100;
PVector[][] controlGrid;
int[] knotsI;
int[] knotsJ;
int resolutionI = 150;
int resolutionJ = 150;
PVector[][] outputGrid = new PVector[resolutionI][resolutionJ];
int DI = 3;
int DJ = 3;
int NI = 0;
int NJ = 0;

void setup(){
  //fullScreen(P3D);
  //strokeWeight(5);
  size(500, 500, P3D);
  NI = width/pSize;
  NJ = height/pSize;
  controlGrid = new PVector[NI+1][NJ+1];
  for(int y = 0; y <= NJ; y++){
    for(int x = 0; x <= NI; x++){
      float ht = noise(float(x)/NI*2, float(y)/NJ*2)*height;
      controlGrid[x][y] = new PVector(x*pSize, ht, y*pSize);
    }
  }
  knotsI = SplineKnots(NI, DI);
  knotsJ = SplineKnots(NJ, DJ);
  Calculate();
}

void draw(){
  background(255);
  lights();
  translate(width/2, 0, -height);
  rotateX((float)frameCount/1000);
  rotateY((float)frameCount/100);
  rotateZ((float)frameCount/1000);
  translate(-width/2, 0, -height/2);
  stroke(0);
  noFill();
  for(int j = 0; j < NJ; j++){
    beginShape(TRIANGLE_STRIP);
    for(int i = 0; i <= NI; i++){
      vertex(controlGrid[i][j]);
      vertex(controlGrid[i][j+1]);
    }
    endShape();
  }
  noStroke();
  fill(255);
  for(int j = 0; j < resolutionJ - 1; j++){
    beginShape(TRIANGLE_STRIP);
    for(int i = 0; i < resolutionI; i++){
      vertex(outputGrid[i][j]);
      vertex(outputGrid[i][j+1]);
    }
    endShape();
  }
}
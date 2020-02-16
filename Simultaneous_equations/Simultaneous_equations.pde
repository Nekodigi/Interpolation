ArrayList<PVector> ps = new ArrayList<PVector>();

void setup(){
  size(1000, 1000);
  
}

void draw(){
  background(255);
  for(PVector p : ps){
    ellipse(p.x, p.y, 10, 10);
  }
  float[] solved = solve(ps);
  float py=0;
  for(int x = 0; x < width; x++){
    float y = 0;
    for(int i = 0; i < ps.size(); i++){
      y += pow(x, (ps.size()-1)-i)*solved[i];
    }
    if(py != 0){
      line(x-1, py, x, y);
    }
    py = y;
  }
}

void keyPressed(){
  if(key=='r'){
    ps = new ArrayList<PVector>();
  }
}

void mousePressed(){
  ps.add(new PVector(mouseX, mouseY));
}

float[] solve(ArrayList<PVector> ps){
  int n = ps.size()-1;
  float[][] A = new float[n+1][n+2];
  
  for(int j = 0; j <= n; j++){
    for(int i = 0; i <= n; i++){
      A[j][i] = pow(ps.get(j).x, n-i);
    }
    A[j][n+1] = ps.get(j).y;
  }
  return simultaSolve(A);
}

float[] simultaSolve(float[][] a){
  float t = 0;
  for(int k = 0; k < a.length; k++){
    for(int i = k + 1; i < a.length; i++){
      t = a[i][k] / a[k][k];
      for(int j = k + 1; j <=a.length; j++){
        a[i][j] -= a[k][j] * t;
      }
    }
  }
  
  for(int i = a.length-1; i >= 0; i--){
    t = a[i][a.length];
    for(int j = i + 1; j < a.length; j++) t -= a[i][j] * a[j][a.length];
    a[i][a.length] = t / a[i][i];
  }
  float[] result = new float[a.length];
  for(int k = 0; k < a.length; k++){
    result[k] = a[k][a.length];
  }
  return result;
}
ArrayList<PVector> ps = new ArrayList<PVector>();
float EPSILON = 0.1;

void setup(){
  //size(1000, 1000);
  fullScreen();
  strokeWeight(20);
}

void draw(){
  background(255);
  for(PVector p : ps){
    ellipse(p.x, p.y, 10, 10);
  }
  float[] solved = solve(ps);
  float py=0;
  for(int x = 0; x < width; x++){
    float y = f(x, solved);
    float k = abs(ddf(x, solved))/pow(1+pow(df(x, solved), 2), 3/2);
    stroke(k*100000, 0, 0);
    if(py != 0){
      line(x-1, py, x, y);
    }
    py = y;
  }
}

float ddf(float x, float[] solved){
  return (df(x+EPSILON, solved)-df(x, solved))/EPSILON;
}

float df(float x, float[] solved){
  float y = 0;
  int k = 1;
  for(int i = 0; i < ps.size(); i++){
    int n = max((ps.size()-k)-i, 0);
    if (n == 0)continue;
    y += pow(x, n-1)*solved[i]*n;
  }
  return y;
}

float f(float x, float[] solved){
  float y = 0;
  for(int i = 0; i < ps.size(); i++){
    y += pow(x, (ps.size()-1)-i)*solved[i];
  }
  return y;
}

float P(int x, int deg){
  float y = 1;
  for(int i = 0; i < deg; i++){
    y *= (x-i);
  }
  return y;
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
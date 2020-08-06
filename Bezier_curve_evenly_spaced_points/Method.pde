PVector P(float t){//based on these site https://en.wikipedia.org/wiki/B%C3%A9zier_curve
  PVector result = new PVector();
  for(int i = 0; i < B.size(); i++){
    result.add(PVector.mult(B.get(i), J(B.size()-1, i, t)));
  }
  return result;
}

float J(int n, int i, float t){
  float b = binomial(n, i);
  return b*pow(t, i)*pow(1-t, n-i);
}

int binomial(int n, int k){
  if(k > n-k){
    k = n-k;//speed up
  }
  int b = 1;
  for(int i = 1; i <= k; i++){
    b *= (n+1-i)/i;
  }
  return b;
}

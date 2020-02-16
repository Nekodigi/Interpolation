float lagrange(float x, ArrayList<Float> xs, ArrayList<Float> ys){
  float L = 0;
  for(int j = 0; j < xs.size(); j++){
    float xj = xs.get(j);
    float lj = 1;
    for(int m = 0; m < xs.size(); m++){
      float xm = xs.get(m);
      if(m != j){
        lj *= (x-xm)/(xj-xm);
      }
    }
    L += ys.get(j)*lj;
  }
  return L;
}
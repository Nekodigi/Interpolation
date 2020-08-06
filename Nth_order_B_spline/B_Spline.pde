PVector Spline(float t, boolean close){//Position at t.
  PVector sum = new PVector();
  PVector p;
  for(int i = -n; i < P.size()+n; i++){
    if(close){//Connect start and end
      p = P.get((int)oMod(i,P.size()));
      sum.add(PVector.mult(p, basis(i, n, t)));
    }else{//Separate start and end
      p = P.get((int)constrain(i, 0, P.size()-1));
      sum.add(PVector.mult(p, basis(i, n, t)));
    }
  }
  return sum;
}

float oMod(float a, float b){//original mod. if -1%8, return 7
  float result = a%b;
  while(result < 0){
    result += b;
  }
  return result;
}

float basis(int j, int k, float t) {//B-spline basis function
  if (k == 0) {
    if (T(j) <= t && t < T(j+1)) {
      return 1;
    } else {
      return 0;
    }
  }
  float t1 = (t-T(j))/(T(j+k)-T(j));
  float t2 = (T(j+k+1)-t)/(T(j+k+1)-T(j+1));
  return t1*basis(j, k-1, t) + t2*basis(j+1, k-1, t);
}

float T(int j) {//knots point
  return j/((float)m-1);
}
int[] SplineKnots(int n, int t){//size of control point, degree
  int[] u = new int[n + t + 1];
  
  for(int j = 0; j < n + t + 1; j++){
    if(j < t) u[j] = 0;
    else if(j <= n) u[j] = j - t + 1;
    else if(j > n) u[j] = n - t + 2;
  }
  return u;
}

float SplineBlend(int k, int t, int[] u, float v){
  float rvalue = 0;
  if (t == 1){
    if ((u[k] <= v)&&(v < u[k + 1]))
      rvalue = 1;
    else
      rvalue = 0;
  }else{
    if ((u[k + t - 1] == u[k])&&(u[k + t] == u[k + 1]))
      rvalue = 0;
    else if(u[k + t - 1] == u[k])
      rvalue = (u[k + t] - v) / (u[k + t] - u[k + 1]) * SplineBlend(k + 1, t - 1, u, v);
    else if(u[k + t] == u[k + 1])
      rvalue = (v - u[k]) / (u[k + t - 1] - u[k]) * SplineBlend(k, t - 1, u, v);
    else//same as above two formula
      rvalue = (v - u[k]) / (u[k + t - 1] - u[k]) * SplineBlend(k, t - 1, u, v) + (u[k + t] - v) / (u[k + t] - u[k + 1]) * SplineBlend(k + 1, t - 1, u, v);
  }
  return rvalue;
}
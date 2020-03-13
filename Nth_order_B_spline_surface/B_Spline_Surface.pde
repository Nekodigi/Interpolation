void Calculate(){
  float incrementI, u, incrementJ, v;//u,v is position on surface
  incrementI = (NI - DI + 2) / ((float)resolutionI - 1+0.001);
  incrementJ = (NJ - DJ + 2) / ((float)resolutionJ - 1+0.001);
  
  u = 0;
  for(int i = 0; i < resolutionI; i++){
    v = 0;
    for(int j = 0; j < resolutionJ; j++){
      PVector sum = new PVector();
      for(int ki = 0; ki <= NI; ki++){
        for(int kj = 0; kj <= NJ; kj++){
          float bi = SplineBlend(ki, DI, knotsI, u);
          float bj = SplineBlend(kj, DJ, knotsJ, v);
          sum.add(PVector.mult(controlGrid[ki][kj], bi*bj));
        }
      }
      outputGrid[i][j] = sum;
      v += incrementJ;
    }
    u += incrementI;
  }
}
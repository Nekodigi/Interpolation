ArrayList<Float> xs = new ArrayList<Float>();
ArrayList<Float> ys = new ArrayList<Float>();

void setup(){
  size(500, 500);
  stroke(255);
}

void draw(){
  background(0);
  for(int xp = 0; xp < width; xp++){
    line(xp, lagrange(xp, xs, ys), xp+1, lagrange(xp+1, xs, ys));
  }
  for(int i = 0; i < xs.size(); i++){
    ellipse(xs.get(i), ys.get(i), 10, 10);
  }
}

void mousePressed(){
  xs.add((float)mouseX);
  ys.add((float)mouseY);
}
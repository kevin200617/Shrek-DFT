Phasor[] fourierX;
Phasor[] fourierY;
ArrayList<PVector> path = new ArrayList<PVector>();
float[] imageX;
float[] imageY;
float dt;
float time = 0;
int skip = 4;


void setup() {
  size(1000, 800);
  loadImage();
  fourierX = dft(imageX);
  fourierY = dft(imageY);
  
  Sort(fourierX);
  Sort(fourierY);
  
  dt = TWO_PI / fourierX.length;
}


void draw() {
  float[] vx = new float[2];
  float[] vy = new float[2];
  background(0);
  time += dt;
  if (time > TWO_PI){
  //noLoop();
  }
  
  vx = epiCycles(width/2,100, fourierX, 0);
  line(vx[0], 0, vx[0], height);

  vy = epiCycles(100,height/2, fourierY, HALF_PI);
  line(0, vy[1], width, vy[1]);
  
  circle(vx[0], vy[1], 5);
  path.add(new PVector(vx[0], vy[1]));
  
  noFill();
  beginShape();
  for (PVector vertex : path) {
    vertex(vertex.x, vertex.y);
  }
  endShape();
}


void loadImage() {
  JSONArray image = loadJSONObject("Shrek xy outline - no face.json").getJSONArray("drawing");
  imageX = new float[image.size()/skip];
  imageY = new float[iamge.size()/skip];

  for (int i = 0; i < train.size()/skip; i+= 1) {
    imageX[i] = image.getJSONObject(i*skip).getFloat("x");
    imageY[i] = image.getJSONObject(i*skip).getFloat("y");
  }
}


float[] epiCycles(float x, float y, Phasor[] Phasors, float rotation){
  float oldx;
  float oldy;
  float[] point = new float[2];
  for (int i = 0; i < Phasors.length; i++) {
    oldx = x;
    oldy = y;
    
    Phasor Phasor = Phasors[i];
    PVector vec = Phasor.state(time, rotation);
    
    x += vec.x;
    y += vec.y;

    noFill();
    stroke(52);
    circle(oldx, oldy, Phasor.amplitude * 2);

    fill(255);
    stroke(255);
    line(oldx, oldy, x, y);
  }
  
  circle(x,y,5);
  point[0] = x;
  point[1] = y;
  return point;
}

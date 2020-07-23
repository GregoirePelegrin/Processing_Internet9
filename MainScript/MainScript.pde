// TODO: How can there be holes in the terrain??

Terrain terrain;
int cols;
int lines;
int sizeCell;
FloatList amplitudes;
FloatList frequencies;
float perlinSpeed;
float lacunarity;
float persistance;
int nbrLayers;
int terrainSize;
int visibleLayer;
int maxAmp;

void setup() {
  size(600, 600, P3D);
  frameRate(30);

  sizeCell = 10;
  cols = width/sizeCell + 1;
  lines = height/sizeCell + 1;
  perlinSpeed = 0.05;
  lacunarity = 2;
  persistance = 0.5;
  nbrLayers = 5;
  visibleLayer = 0;

  terrainSize = 400;
  maxAmp = 200;
  amplitudes = new FloatList();
  frequencies = new FloatList();

  for (int i=0; i<nbrLayers; i++) {
    amplitudes.append(maxAmp * pow(persistance, i));
    frequencies.append(pow(lacunarity, i));
  }

  terrain = new Terrain(amplitudes, frequencies);
}

void draw() {
  background(0);
  translate(0, height/3);
  rotateX(PI/3);
  
  stroke(255);
  noFill();
  
  terrain.display();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (visibleLayer == amplitudes.size()) {
      visibleLayer = 0;
    } else {
      visibleLayer++;
    }
    println("Layer ", visibleLayer, " is visible");
  } else if (mouseButton == RIGHT) {
    println("New terrain");
    visibleLayer = 0;
    terrain.update();
  }
}

float persoMin(float a[][]) {
  float min = 0;
  for (int i=0; i<a.length; i++) {
    for (int j=0; j<a[0].length; j++) {
      if (a[i][j] < min) {
        min = a[i][j];
      }
    }
  }
  return min;
}

float persoMax(float a[][]) {
  float max = 255;
  for (int i=0; i<a.length; i++) {
    for (int j=0; j<a[0].length; j++) {
      if (a[i][j] > max) {
        max = a[i][j];
      }
    }
  }
  return max;
}

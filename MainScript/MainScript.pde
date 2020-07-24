import peasy.*;

PeasyCam  cam;

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
int maxAmpDisplay;

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 700);
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
  maxAmpDisplay = 100;
  amplitudes = new FloatList();
  frequencies = new FloatList();

  for (int i=0; i<nbrLayers; i++) {
    amplitudes.append(maxAmp * pow(persistance, i));
    frequencies.append(pow(lacunarity, i));
  }

  terrain = new Terrain(amplitudes, frequencies);
}

void draw() {
  ambientLight(0, 0, 255);
  directionalLight(255, 255, 255, 1, 0, 0);
  background(0);

  stroke(255);
  //noFill();

  terrain.display();
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    if (visibleLayer == amplitudes.size()) {
      visibleLayer = 0;
    } else {
      visibleLayer++;
    }
    println("Layer ", visibleLayer, " is visible");
  } else if (mouseButton == CENTER) {
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

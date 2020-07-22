// TODO: Transform the script to display the terrain

Terrain terrain;
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
  // Begin in 2D, then implementing the 3rd dimension
  size(600, 600);
  //size(600, 600, P3D);
  frameRate(30);

  perlinSpeed = 0.005;
  lacunarity = 2;
  persistance = 0.5;
  nbrLayers = 5;
  visibleLayer = 0;

  terrainSize = 400;
  maxAmp = 100;
  amplitudes = new FloatList();
  frequencies = new FloatList();

  for (int i=0; i<nbrLayers; i++) {
    //amplitudes.append(maxAmp * pow(persistance, i)); To implement, in order to have a correct variation of z-coordinates
    amplitudes.append(pow(persistance, i));
    frequencies.append(pow(lacunarity, i));
  }

  terrain = new Terrain(amplitudes, frequencies);
}

void draw() {
  background(0);

  terrain.display();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (visibleLayer == amplitudes.size()) {
      visibleLayer = 0;
    } else {
      visibleLayer++;
    }
  } else if (mouseButton == RIGHT) {
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

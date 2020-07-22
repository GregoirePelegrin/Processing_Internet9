class Layer {
  float amp;
  float freq;

  float greyscale[][];

  Layer(float a, float f) {
    this.amp = a;
    this.freq = f;
    this.greyscale = new float[width][height];
  }

  void update() {
    float xOffset = random(10000);
    float yOffset = random(10000);
    for (int y=0; y<height; y++) {
      for (int x=0; x<width; x++) {
        this.greyscale[x][y] = this.amp*noise(x*perlinSpeed*freq + xOffset, y*perlinSpeed*freq + yOffset) * 255; // To map this to a greyscale
      }
    }
  }

  void display() {
    for (int y=0; y<height; y++) {
      for (int x=0; x<width; x++) {
        stroke(this.greyscale[x][y]);
        point(x, y);
      }
    }
  }
}

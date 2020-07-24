class Layer {
  float amp;
  float freq;

  float zPos[][];

  Layer(float a, float f) {
    this.amp = a;
    this.freq = f;
    this.zPos = new float[cols][lines];
  }

  void update() {
    float xOffset = random(10000);
    float yOffset = random(10000);
    for (int y=0; y<lines; y++) {
      for (int x=0; x<cols; x++) {
        this.zPos[x][y] = this.amp*noise(x*perlinSpeed*freq + xOffset, y*perlinSpeed*freq + yOffset);
      }
    }
  }

  void display() {
    for (int y=0; y<lines-1; y++) {
      beginShape(TRIANGLE_STRIP);
      for (int x=0; x<cols; x++) {
        vertex(x*sizeCell, y*sizeCell, this.zPos[x][y]);
        vertex(x*sizeCell, (y+1)*sizeCell, this.zPos[x][y+1]);
      }
      endShape();
    }
  }
}

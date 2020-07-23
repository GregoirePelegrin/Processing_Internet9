class Terrain {
  FloatList amps;
  FloatList freqs;
  ArrayList<Layer> layers;

  float zPos[][];

  Terrain(FloatList a, FloatList f) {
    this.amps = a;
    this.freqs = f;
    this.layers = new ArrayList<Layer>();

    this.zPos = new float[cols][lines];

    for (int i=0; i<this.amps.size(); i++) {
      Layer layer = new Layer(this.amps.get(i), this.freqs.get(i));
      layers.add(layer);
    }
    this.update();
  }

  void update() {
    for (Layer layer : this.layers) {
      layer.update();
    }

    for (int y=0; y<lines; y++) {
      for (int x=0; x<cols; x++) {
        float sum=0;
        for (Layer layer : this.layers) {
          sum += layer.zPos[x][y];
        }
        this.zPos[x][y] = sum;
      }
    }
    float minscale = persoMin(this.zPos);
    float maxscale = persoMax(this.zPos);
    for (int y=0; y<lines; y++) {
      for (int x=0; x<cols; x++) {
        this.zPos[x][y] = map(this.zPos[x][y], minscale, maxscale, 0, maxAmp);
      }
    }
  }

  void display() {
    if (visibleLayer == amplitudes.size()) {
      for (int y=0; y<lines; y++) {
        beginShape(TRIANGLE_STRIP);
        for (int x=0; x<cols; x++) {
          vertex(x*sizeCell, y*sizeCell, this.zPos[x][y]);
          vertex(x*sizeCell, (y+1)*sizeCell, this.zPos[x][y]);
        }
        endShape();
      }
    } else {
      this.layers.get(visibleLayer).display();
    }
  }
}

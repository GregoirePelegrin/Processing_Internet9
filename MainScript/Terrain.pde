class Terrain {
  FloatList amps;
  FloatList freqs;
  ArrayList<Layer> layers;

  float greyscale[][];

  Terrain(FloatList a, FloatList f) {
    this.amps = a;
    this.freqs = f;
    this.layers = new ArrayList<Layer>();

    this.greyscale = new float[width][height];

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

    for (int y=0; y<width; y++) {
      for (int x=0; x<width; x++) {
        float sum=0;
        for (Layer layer : this.layers) {
          sum += layer.greyscale[x][y];
        }
        this.greyscale[x][y] = sum;
      }
    }
    float minscale = persoMin(this.greyscale);
    float maxscale = persoMax(this.greyscale);
    for (int y=0; y<width; y++) {
      for (int x=0; x<width; x++) {
        this.greyscale[x][y] = map(this.greyscale[x][y], minscale, maxscale, 0, 255);
      }
    }
  }

  void display() {
    // If visibleLayer == amplitudes.size(), all the Layers should be visible and stacked on one another
    if (visibleLayer == amplitudes.size()) {
      for (int y=0; y<height; y++) {
        for (int x=0; x<width; x++) {
          stroke(this.greyscale[x][y]);
          point(x, y);
        }
      }
    } else {
      this.layers.get(visibleLayer).display();
    }
  }
}

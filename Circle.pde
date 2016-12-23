class Circle 
{
  Body body;
  float size;
  PImage img;

  Circle(float x_, float y_, float size_) {
    size = size_;
    makeBody(new Vec2(x_, y_));
    
    float rPower = random(0.5, 0.8);
    float gPower = random(0.5, 0.8);
    float bPower = random(0.5, 0.8);
    int pSize = int(size * 10);
    float center = pSize / 2;
    
    this.img = createImage(pSize, pSize, RGB);
    for(int y = 0; y < pSize; y++)
    {
      for(int x = 0; x < pSize; x++)
      {
        float distance = (sq(center -x) + sq(center - y)) / 50;
        int r = int((255 * rPower) / distance);
        int g = int((255 * gPower) / distance);
        int b = int((255 * bPower) / distance);
        img.pixels[x + y * pSize] = color(r, g, b);
      }
    }
  }

  void makeBody(Vec2 center) {

    CircleShape cs = new CircleShape();
    float box2dSize = box2d.scalarPixelsToWorld(size);
    cs.setRadius(box2dSize / 2);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 0.5;
    fd.restitution = 0.5;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);
  }

  boolean isDead() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.x < 0 || pos.x > width + size || pos.y > height + size) {
      box2d.destroyBody(body);
      return true;
    }
    return false;
  }

  void display() 
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    image(img, pos.x, pos.y);
  }
}
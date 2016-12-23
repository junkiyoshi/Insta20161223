import shiffman.box2d.*;

import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;

Box2DProcessing box2d;

ArrayList<Circle> circles;
Floor floor;

void setup()
{
  size(1080, 1080);
  background(0);
  frameRate(60);
  imageMode(CENTER);
  blendMode(ADD);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -20);
  
  circles = new ArrayList<Circle>();
  floor = new Floor();
}

void draw()
{
  background(0);
  box2d.step();
  
  if(frameCount % 2 == 0)
  {
    Circle circle = new Circle(random(width), -15, 20);
    circle.body.setLinearVelocity(new Vec2(random(-2, 2), 0));
    circles.add(circle);
  }
  
  for(Circle c : circles)
  {
    c.display();
  }
  
  for(int i = circles.size() - 1; i >= 0; i--)
  {
    Circle c = circles.get(i);
    if(c.isDead())
    {
      circles.remove(i);
    }
  }
  
  floor.display();
  
  println(frameCount);
  /*
  saveFrame("screen-#####.png");
  if(frameCount > 1800)
  {
     exit();
  } 
  */
}
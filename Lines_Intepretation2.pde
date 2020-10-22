
import peasy.PeasyCam;
import punktiert.math.Vec;
import punktiert.physics.*;

VPhysics physics;
PeasyCam cam;

//Variables
float pSpeed = 5.0f;
int pNumber = 90;
int i = 0;
float weight;
double camDist;
int bgColour = 255;

public void setup() {

  size(1280, 720, P3D);
  smooth(40);

  cam = new PeasyCam(this, 800);
  cam.setMinimumDistance(100); 
  cam.setMaximumDistance(1300); 
  cam.setWheelScale(0.5);

  colorMode(RGB);

  physics = new VPhysics();

  //Spawning of Particles
  for (int i = 0; i < pNumber; i++) {

    //Particle Class
    Vec pos = new Vec(0, 0, 0).jitter(1);
    Vec vel = new Vec(random(-1, 1), random(-1, 1), random(-1, 1));
    VBoid p = new VBoid(pos, vel);

    //Particle behaviour
    p.swarm.setSeperationScale(1.0f);
    p.swarm.setSeperationRadius(40);
    p.swarm.setMaxSpeed(pSpeed);
    physics.addParticle(p);
    p.addBehavior(new BCollision());
    physics.addSpring(new VSpringRange(p, new VParticle(), 100, 600, 0.00003f));
  }
}


public void draw() {
  background(bgColour);
  physics.update();

  //Data storing of the Particles
  for (i = 0; i < physics.particles.size(); i++) {
    VBoid boid = (VBoid) physics.particles.get(i);
    //3 Colour Groups
    if ( i %2 == 0)
    {
      strokeWeight(3);
      stroke(255, 165, 0, 220);
      strokeWeight(4);
    } else if (i % 3 == 0)
    {
      stroke(255, 0, 0, 220);
    } else 
    stroke(119, 136, 153, 220);

    //Set Trail Length
    point(boid.x, boid.y, boid.z);
    boid.trail.setInPast(500);

    //Calculate Camera Distance, and adjust strokeWeight
    camDist = cam.getDistance();
    if (camDist <= 150)
    {
      weight = 2.3;
    } else if (camDist >150 && camDist <= 300)
    {
      weight = 1.5;
    } else if (camDist >150 && camDist <= 300)
    {
      weight = 1.3;
    } else {
      weight = 1;
    }
    strokeWeight(weight);
    noFill();
    beginShape();
    for (int j = 0; j < boid.trail.particles.size(); j++) {
      VParticle t = boid.trail.particles.get(j);
      vertex(t.x, t.y, t.z);
    }

    endShape();
  }
  //Output
  //saveFrame("Framesv2_01/FinalProjectv2_01_####.png");
}

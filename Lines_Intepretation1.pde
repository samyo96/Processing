
import peasy.PeasyCam;
import punktiert.math.Vec;
import punktiert.physics.*;

VPhysics physics;

PeasyCam cam;

//Variables
float pSpeed = 5.0f;
int pNumber = 80;

public void setup() {


  size(1280, 720, P3D);
  smooth(40);

  cam = new PeasyCam(this, 800);

  physics = new VPhysics();

  //Spawning of Particles
  for (int i = 0; i < pNumber; i++) {

    Vec pos = new Vec(0, 0, 0).jitter(1);
    Vec vel = new Vec(random(-1, 1), random(-1, 1), random(-1, 1));
    VBoid p = new VBoid(pos, vel);
    p.swarm.setSeperationScale(1.0f);
    p.swarm.setSeperationRadius(40);
    p.swarm.setMaxSpeed(pSpeed);
    physics.addParticle(p);
    p.addBehavior(new BCollision());
    physics.addSpring(new VSpringRange(p, new VParticle(), 100, 600, 0.00003f));
  }
}

public void draw() {
  background(255);
  physics.update();

  //Data storing of the Particles
  for (int i = 0; i < physics.particles.size(); i++) {
    VBoid boid = (VBoid) physics.particles.get(i);

    stroke(#FFA500); // Particle colour
    point(boid.x, boid.y, boid.z);
    boid.trail.setInPast(500);

    strokeWeight(1);
    stroke(#FFA500); // Trail colour
    noFill();
    beginShape();
    for (int j = 0; j < boid.trail.particles.size(); j++) {
      VParticle t = boid.trail.particles.get(j);
      vertex(t.x, t.y, t.z);
    }
    endShape();
  }
  //saveFrame("Framesv1.01/FinalProjectv101_####.png");
}

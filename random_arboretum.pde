/*
Random Arboretum Example from the Traer Physics library.
Ported to Processing by bitcraft (https://www.openprocessing.org/sketch/207990)
https://creativecommons.org/licenses/by-sa/3.0/
*/


final float NODE_SIZE = 10;
final float EDGE_LENGTH = 20;
final float EDGE_STRENGTH = 0.2;
final float SPACER_STRENGTH = 1000;

ParticleSystem physics;
float zoom = 1;
float centroidX = 0;
float centroidY = 0;

void setup()
{
  size( 400, 400 );
  smooth();
  strokeWeight( 2 );
  ellipseMode( CENTER );       
  
  physics = new ParticleSystem( 0, 0.1 );
  
  // Runge-Kutta, the default integrator is stable and snappy,
  // but slows down quickly as you add particles.
  // 500 particles = 7 fps on my machine
  
  // Try this to see how Euler is faster, but borderline unstable.
  // 500 particles = 24 fps on my machine
  physics.setIntegrator( ParticleSystem.MODIFIED_EULER ); 
  
  // Now try this to see make it more damped, but stable.
  physics.setDrag( 0.2 );
  
  
  //textFont( loadFont( "AkzidenzGroteskBQ-Regular-14.vlw" ) );
  
  initialize();
}

void draw()
{
  physics.tick(); 
  if ( physics.numberOfParticles() > 1 )
    updateCentroid();
  background( 255 );
  fill( 0 );
  text( "" + physics.numberOfParticles() + " PARTICLES\n" + (int)frameRate + " FPS", 10, 20 );
  translate( width/2 , height/2 );
  scale( zoom );
  translate( -centroidX, -centroidY );
 
  drawNetwork();  
}

void drawNetwork()
{      
  // draw vertices
  fill( 160 );
  noStroke();
  for ( int i = 0; i < physics.numberOfParticles(); ++i )
  {
    Particle v = physics.getParticle( i );
    ellipse( v.position.x, v.position.y, NODE_SIZE, NODE_SIZE );
  }

  // draw edges 
  stroke( 0 );
  beginShape( LINES );
  for ( int i = 0; i < physics.numberOfSprings(); ++i )
  {
    Spring e = physics.getSpring( i );
    Particle a = e.getOneEnd();
    Particle b = e.getTheOtherEnd();
    vertex( a.position.x, a.position.y );
    vertex( b.position.x, b.position.y );
  }
  endShape();
}

void mousePressed()
{
  addNode();
}

void mouseDragged()
{
  addNode();
}

void keyPressed()
{
  if ( key == 'c' )
  {
    initialize();
    return;
  }
  
  if ( key == ' ' )
  {
    addNode();
    return;
  }
}

// ME ////////////////////////////////////////////

void updateCentroid()
{
  float xMax = -999999.9, 
    xMin = +999999.9, 
    yMin = +999999.9, 
    yMax = -999999.9;

  for ( int i = 0; i < physics.numberOfParticles(); ++i )
  {
    Particle p = physics.getParticle( i );
    xMax = max( xMax, p.position.x );
    xMin = min( xMin, p.position.x );
    yMin = min( yMin, p.position.y );
    yMax = max( yMax, p.position.y );
  }
  float deltaX = xMax-xMin;
  float deltaY = yMax-yMin;
  
  centroidX = xMin + 0.5*deltaX;
  centroidY = yMin +0.5*deltaY;
  
  if ( deltaY > deltaX )
    zoom = height/(deltaY+50);
  else
    zoom = width/(deltaX+50);
}

void addSpacersToNode( Particle p, Particle r )
{
  for ( int i = 0; i < physics.numberOfParticles(); ++i )
  {
    Particle q = physics.getParticle( i );
    if ( p != q && p != r )
      physics.makeAttraction( p, q, -SPACER_STRENGTH, 20 );
  }
}

void makeEdgeBetween( Particle a, Particle b )
{
  physics.makeSpring( a, b, EDGE_STRENGTH, EDGE_STRENGTH, EDGE_LENGTH );
}

void initialize()
{
  physics.clear();
  physics.makeParticle();
}

void addNode()
{ 
  Particle p = physics.makeParticle();
  Particle q = physics.getParticle( (int)random( 0, physics.numberOfParticles()-1) );
  while ( q == p )
    q = physics.getParticle( (int)random( 0, physics.numberOfParticles()-1) );
  addSpacersToNode( p, q );
  makeEdgeBetween( p, q );
  p.position.set( q.position.x + random( -1, 1 ), q.position.y + random( -1, 1 ), 0 );
}
import java.util.Iterator;

// Traer Physics 3.0
// Terms from Traer's download page, http://traer.cc/mainsite/physics/
//   LICENSE - Use this code for whatever you want, just send me a link jeff@traer.cc
//
// traer3a_01.pde 
//   From traer.physics - author: Jeff Traer
//     Attraction              Particle                     
//     EulerIntegrator         ParticleSystem  
//     Force                   RungeKuttaIntegrator         
//     Integrator              Spring
//     ModifiedEulerIntegrator Vector3D          
//
//   From traer.animator - author: Jeff Traer   
//     Smoother                                       
//     Smoother3D                  
//     Tickable     
//
//   New code - author: Carl Pearson
//     UniversalAttraction
//     Pulse
//

// 13 Dec 2010: Copied 3.0 src from http://traer.cc/mainsite/physics/ and ported to Processingjs,
//              added makeParticle2(), makeAttraction2(), replaceAttraction(), and removeParticle(int) -mrn (Mike Niemi)
//  9 Feb 2011: Fixed bug in Euler integrators where they divided by time instead of 
//              multiplying by it in the update steps,
//              eliminated the Vector3D class (converting the code to use the native PVector class),
//              did some code compaction in the RK solver,
//              added a couple convenience classes, UniversalAttraction and Pulse, simplifying 
//              the Pendulums sample (renamed to dynamics.pde) considerably. -cap (Carl Pearson)
// 24 Mar 2011: Changed the switch statement in ParticleSystem.setIntegrator() to an if-then-else
//              to avoid an apparent bug introduced in Processing-1.1.0.js where the 
//              variable, RUNGE_KUTTA, was not visible inside the switch statement.
//              Changed ModifiedEulerIntegrator to use the documented PVector interfaces to work with pjs. -mrn
//  8 Jan 2013: Added "import java.util.Iterator" so it will now work in the Processing 2.0 IDE,
//              just flip the mode buttion in the upper right corner of the IDE between "JAVA" to "JAVASCRIPT".

//===========================================================================================
//                                      Attraction
//===========================================================================================
// attract positive repel negative
//package traer.physics;
public class Attraction implements Force
{
  Particle one;
  Particle b;
  float k;
  boolean on = true;
  float distanceMin;
  float distanceMinSquared;
  
  public Attraction( Particle a, Particle b, float k, float distanceMin )
  {
    this.one = a;
    this.b = b;
    this.k = k;
    this.distanceMin = distanceMin;
    this.distanceMinSquared = distanceMin*distanceMin;
  }

  protected void        setA( Particle p )            { one = p; }
  protected void        setB( Particle p )            { b = p; }
  public final float    getMinimumDistance()          { return distanceMin; }
  public final void     setMinimumDistance( float d ) { distanceMin = d; distanceMinSquared = d*d; }
  public final void     turnOff()                     { on = false; }
  public final void     turnOn()                { on = true;  }
  public final void     setStrength( float k )        { this.k = k; }
  public final Particle getOneEnd()                   { return one; }
  public final Particle getTheOtherEnd()              { return b; }
  
  public void apply() 
  { if ( on && ( one.isFree() || b.isFree() ) )
      {
        PVector a2b = PVector.sub(one.position, b.position, new PVector());
        float a2bDistanceSquared = a2b.dot(a2b);

  if ( a2bDistanceSquared < distanceMinSquared )
     a2bDistanceSquared = distanceMinSquared;

  float force = k * one.mass0 * b.mass0 / (a2bDistanceSquared * (float)Math.sqrt(a2bDistanceSquared));

        a2b.mult( force );

  // apply
        if ( b.isFree() )
     b.force.add( a2b );  
        if ( one.isFree() ) {
           a2b.mult(-1f);
     one.force.add( a2b );
        }
      }
  }

  public final float   getStrength() { return k; }
  public final boolean isOn()        { return on; }
  public final boolean isOff()       { return !on; }
} // Attraction

//===========================================================================================
//                                    UniversalAttraction
//===========================================================================================
// attract positive repel negative
public class UniversalAttraction implements Force {
  public UniversalAttraction( float k, float distanceMin, ArrayList targetList )
  {
    this.k = k;
    this.distanceMin = distanceMin;
    this.distanceMinSquared = distanceMin*distanceMin;
    this.targetList = targetList;
  }
  
  float k;
  boolean on = true;
  float distanceMin;
  float distanceMinSquared;
  ArrayList targetList;
  public final float    getMinimumDistance()          { return distanceMin; }
  public final void     setMinimumDistance( float d ) { distanceMin = d; distanceMinSquared = d*d; }
  public final void     turnOff()                     { on = false; }
  public final void     turnOn()                { on = true;  }
  public final void     setStrength( float k )        { this.k = k; }
  public final float   getStrength() { return k; }
  public final boolean isOn()        { return on; }
  public final boolean isOff()       { return !on; }

  
  public void apply() 
  { 
    if ( on ) {
        for (int i=0; i < targetList.size(); i++ ) {
          for (int j=i+1; j < targetList.size(); j++) {
            Particle a = (Particle)targetList.get(i);
            Particle b = (Particle)targetList.get(j);
            if ( a.isFree() || b.isFree() ) {
              PVector a2b = PVector.sub(a.position, b.position, new PVector());
              float a2bDistanceSquared = a2b.dot(a2b);
              if ( a2bDistanceSquared < distanceMinSquared )
              a2bDistanceSquared = distanceMinSquared;
              float force = k * a.mass0 * b.mass0 / (a2bDistanceSquared * (float)Math.sqrt(a2bDistanceSquared));
              a2b.mult( force );

              if ( b.isFree() ) b.force.add( a2b );  
              if ( a.isFree() ) {
                 a2b.mult(-1f);
                 a.force.add( a2b );
              }
            }
          }
        }
    }
  }
} //UniversalAttraction

//===========================================================================================
//                                    Pulse
//===========================================================================================
public class Pulse implements Force {
  public Pulse( float k, float distanceMin, PVector origin, float lifetime, ArrayList targetList )
  {
    this.k = k;
    this.distanceMin = distanceMin;
    this.distanceMinSquared = distanceMin*distanceMin;
    this.origin = origin;
    this.targetList = targetList;
    this.lifetime = lifetime;
  }
  
  float k;
  boolean on = true;
  float distanceMin;
  float distanceMinSquared;
  float lifetime;
  PVector origin;
  ArrayList targetList;
  
  public final void     turnOff() { on = false; }
  public final void     turnOn()  { on = true;  }
  public final boolean  isOn()    { return on; }
  public final boolean  isOff()   { return !on; }
  public final boolean  tick( float time ) { 
    lifetime-=time; 
    if (lifetime <= 0f) turnOff(); 
    return on;
  }
  
  public void apply() {
    if (on) {
      PVector holder = new PVector();
      int count = 0;
      for (Iterator i = targetList.iterator(); i.hasNext(); ) {
        Particle p = (Particle)i.next();
        if ( p.isFree() ) {
          holder.set( p.position.x, p.position.y, p.position.z );
          holder.sub( origin );
          float distanceSquared = holder.dot(holder);
          if (distanceSquared < distanceMinSquared) distanceSquared = distanceMinSquared;
          holder.mult(k / (distanceSquared * (float)Math.sqrt(distanceSquared)) );
          p.force.add( holder );
        }
      }
    }
  }
}//Pulse

//===========================================================================================
//                                      EulerIntegrator
//===========================================================================================
//package traer.physics;
public class EulerIntegrator implements Integrator
{
  ParticleSystem s;
  
  public EulerIntegrator( ParticleSystem s ) { this.s = s; }
  public void step( float t )
  {
    s.clearForces();
    s.applyForces();
    
    for ( Iterator i = s.particles.iterator(); i.hasNext(); )
      {
  Particle p = (Particle)i.next();
  if ( p.isFree() )
          {
      p.velocity.add( PVector.mult(p.force, t/p.mass0) );
      p.position.add( PVector.mult(p.velocity, t) );
    }
      }
  }
} // EulerIntegrator

//===========================================================================================
//                                          Force
//===========================================================================================
// May 29, 2005
//package traer.physics;
// @author jeffrey traer bernstein
public interface Force
{
  public void    turnOn();
  public void    turnOff();
  public boolean isOn();
  public boolean isOff();
  public void    apply();
} // Force

//===========================================================================================
//                                      Integrator
//===========================================================================================
//package traer.physics;
public interface Integrator 
{
  public void step( float t );
} // Integrator

//===========================================================================================
//                                    ModifiedEulerIntegrator
//===========================================================================================
//package traer.physics;
public class ModifiedEulerIntegrator implements Integrator
{
  ParticleSystem s;
  public ModifiedEulerIntegrator( ParticleSystem s ) { this.s = s; }
  public void step( float t )
  {
    s.clearForces();
    s.applyForces();
    
    float halft = 0.5f*t;
//    float halftt = 0.5f*t*t;
    PVector a = new PVector();
    PVector holder = new PVector();
    
    for ( int i = 0; i < s.numberOfParticles(); i++ )
      {
  Particle p = s.getParticle( i );
  if ( p.isFree() )
    { // The following "was"s was the code in traer3a which appears to work in the IDE but not pjs
            // I couln't find the interface Carl used in the PVector documentation and have converted
            // the code to the documented interface. -mrn
            
            // was in traer3a: PVector.div(p.force, p.mass0, a);
            a.set(p.force.x, p.force.y, p.force.z);
            a.div(p.mass0);

      //was in traer3a: p.position.add( PVector.mult(p.velocity, t, holder) );
            holder.set(p.velocity.x, p.velocity.y, p.velocity.z);
            holder.mult(t);
            p.position.add(holder);

      //was in traer3a: p.position.add( PVector.mult(a, halft, a) );
            holder.set(a.x, a.y, a.z);
            holder.mult(halft); // Note that the original Traer code used halftt ( 0.5*t*t ) here -mrn
            p.position.add(holder);

            //was in traer3a: p.velocity.add( PVector.mult(a, t, a) );
            holder.set(a.x, a.y, a.z);
            holder.mult(t);
            p.velocity.add(a);
    }
      }
  }
} // ModifiedEulerIntegrator

//===========================================================================================
//                                         Particle
//===========================================================================================
//package traer.physics;
public class Particle
{
  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector force = new PVector();
  protected float    mass0;
  protected float    age0 = 0;
  protected boolean  dead0 = false;
  boolean            fixed0 = false;
  
  public Particle( float m )
  { mass0 = m; }
  
  // @see traer.physics.AbstractParticle#distanceTo(traer.physics.Particle)
  public final float distanceTo( Particle p ) { return this.position.dist( p.position ); }
  
  // @see traer.physics.AbstractParticle#makeFixed()
  public final Particle makeFixed() {
    fixed0 = true;
    velocity.set(0f,0f,0f);
    force.set(0f, 0f, 0f);
    return this;
  }
  
  // @see traer.physics.AbstractParticle#makeFree()
  public final Particle makeFree() {
    fixed0 = false;
    return this;
  }

  // @see traer.physics.AbstractParticle#isFixed()
  public final boolean isFixed() { return fixed0; }
  
  // @see traer.physics.AbstractParticle#isFree()
  public final boolean isFree() { return !fixed0; }
    
  // @see traer.physics.AbstractParticle#mass()
  public final float mass() { return mass0; }
  
  // @see traer.physics.AbstractParticle#setMass(float)
  public final void setMass( float m ) { mass0 = m; }
    
  // @see traer.physics.AbstractParticle#age()
  public final float age() { return age0; }
  
  protected void reset()
  {
    age0 = 0;
    dead0 = false;
    position.set(0f,0f,0f);
    velocity.set(0f,0f,0f);
    force.set(0f,0f,0f);
    mass0 = 1f;
  }
} // Particle

//===========================================================================================
//                                      ParticleSystem
//===========================================================================================
// May 29, 2005
//package traer.physics;
//import java.util.*;
public class ParticleSystem
{
  public static final int RUNGE_KUTTA = 0;
  public static final int MODIFIED_EULER = 1;
  protected static final float DEFAULT_GRAVITY = 0;
  protected static final float DEFAULT_DRAG = 0.001f;  
  ArrayList  particles = new ArrayList();
  ArrayList  springs = new ArrayList();
  ArrayList  attractions = new ArrayList();
  ArrayList  customForces = new ArrayList();
  ArrayList  pulses = new ArrayList();
  Integrator integrator;
  PVector    gravity = new PVector();
  float      drag;
  boolean    hasDeadParticles = false;
  
  public final void setIntegrator( int which )
  {
    //switch ( which )
    //{
    //  case RUNGE_KUTTA:
    //    this.integrator = new RungeKuttaIntegrator( this );
    //    break;
    //  case MODIFIED_EULER:
    //    this.integrator = new ModifiedEulerIntegrator( this );
    //    break;
    //}
    if ( which==RUNGE_KUTTA )
       this.integrator = new RungeKuttaIntegrator( this );
    else
    if ( which==MODIFIED_EULER )
       this.integrator = new ModifiedEulerIntegrator( this );
  }
  
  public final void setGravity( float x, float y, float z ) { gravity.set( x, y, z ); }

  // default down gravity
  public final void     setGravity( float g ) { gravity.set( 0, g, 0 ); }
  public final void     setDrag( float d )    { drag = d; }
  public final void     tick()                { tick( 1 ); }
  public final void     tick( float t )       {
    integrator.step( t );
    for (int i = 0; i<pulses.size(); ) {
      Pulse p = (Pulse)pulses.get(i);
      p.tick(t);
      if (p.isOn()) { i++; } else { pulses.remove(i); }
    }
    if (pulses.size()!=0) for (Iterator i = pulses.iterator(); i.hasNext(); ) {
      Pulse p = (Pulse)(i.next());
      p.tick( t );
      if (!p.isOn()) i.remove();
    }
  }
  
  public final Particle makeParticle( float mass, float x, float y, float z )
  {
    Particle p = new Particle( mass );
    p.position.set( x, y, z );
    particles.add( p );
    return p;
  }
  
  public final int makeParticle2( float mass, float x, float y, float z )
  { // mrn
    makeParticle(mass, x, y, z);
    return particles.size()-1;
  }
  
  public final Particle makeParticle() { return makeParticle( 1.0f, 0f, 0f, 0f ); }
  
  public final Spring   makeSpring( Particle a, Particle b, float ks, float d, float r )
  {
    Spring s = new Spring( a, b, ks, d, r );
    springs.add( s );
    return s;
  }
  
  public final Attraction makeAttraction( Particle first, Particle b, float k, float minDistance )
  {
    Attraction m = new Attraction( first, b, k, minDistance );
    attractions.add( m );
    return m;
  }
  
  public final int makeAttraction2( Particle a, Particle b, float k, float minDistance )
  { // mrn
    makeAttraction(a, b, k, minDistance);
    return attractions.size()-1; // return the index 
  }

  public final void replaceAttraction( int i, Attraction m )
  { // mrn
    attractions.set( i, m );
  }  

  public final void addPulse(Pulse pu){ pulses.add(pu); }

  public final void clear()
  {
    particles.clear();
    springs.clear();
    attractions.clear();
    customForces.clear();
    pulses.clear();
  }
  
  public ParticleSystem( float g, float somedrag )
  {
    setGravity( 0f, g, 0f );
    drag = somedrag;
    integrator = new RungeKuttaIntegrator( this );
  }
  
  public ParticleSystem( float gx, float gy, float gz, float somedrag )
  {
    setGravity( gx, gy, gz );
    drag = somedrag;
    integrator = new RungeKuttaIntegrator( this );
  }
  
  public ParticleSystem()
  {
    setGravity( 0f, ParticleSystem.DEFAULT_GRAVITY, 0f );
    drag = ParticleSystem.DEFAULT_DRAG;
    integrator = new RungeKuttaIntegrator( this );
  }
  
  protected final void applyForces()
  {
    if ( gravity.mag() != 0f )
      {
        for ( Iterator i = particles.iterator(); i.hasNext(); )
    {
            Particle p = (Particle)i.next();
            if (p.isFree()) p.force.add( gravity );
    }
      }
      
    PVector target = new PVector();
    for ( Iterator i = particles.iterator(); i.hasNext(); )
      {
        Particle p = (Particle)i.next();
        if (p.isFree()) p.force.add( PVector.mult(p.velocity, -drag, target) );

      }
      
    applyAll(springs);
    applyAll(attractions);
    applyAll(customForces);
    applyAll(pulses);
      
    
  }
  
  private void applyAll(ArrayList forces) {
    if( forces.size()!=0 ) for ( Iterator i = forces.iterator(); i.hasNext(); ) ((Force)i.next()).apply();
  }
  
  protected final void clearForces()
  {
    for (Iterator i = particles.iterator(); i.hasNext(); ) ((Particle)i.next()).force.set(0f, 0f, 0f);
  }
  
  public final int        numberOfParticles()              { return particles.size(); }
  public final int        numberOfSprings()                { return springs.size(); }
  public final int        numberOfAttractions()            { return attractions.size(); }
  public final Particle   getParticle( int i )             { return (Particle)particles.get( i ); }
  public final Spring     getSpring( int i )               { return (Spring)springs.get( i ); }
  public final Attraction getAttraction( int i )           { return (Attraction)attractions.get( i ); }
  public final void       addCustomForce( Force f )        { customForces.add( f ); }
  public final int        numberOfCustomForces()           { return customForces.size(); }
  public final Force      getCustomForce( int i )          { return (Force)customForces.get( i ); }
  public final Force      removeCustomForce( int i )       { return (Force)customForces.remove( i ); }
  public final void       removeParticle( int i )          { particles.remove( i ); } //mrn
  public final void       removeParticle( Particle p )     { particles.remove( p ); }
  public final Spring     removeSpring( int i )            { return (Spring)springs.remove( i ); }
  public final Attraction removeAttraction( int i )        { return (Attraction)attractions.remove( i ); }
  public final void       removeAttraction( Attraction s ) { attractions.remove( s ); }
  public final void       removeSpring( Spring a )         { springs.remove( a ); }
  public final void       removeCustomForce( Force f )     { customForces.remove( f ); }
} // ParticleSystem

//===========================================================================================
//                                      RungeKuttaIntegrator
//===========================================================================================
//package traer.physics;
//import java.util.*;
public class RungeKuttaIntegrator implements Integrator
{  
  ArrayList originalPositions = new ArrayList();
  ArrayList originalVelocities = new ArrayList();
  ArrayList k1Forces = new ArrayList();
  ArrayList k1Velocities = new ArrayList();
  ArrayList k2Forces = new ArrayList();
  ArrayList k2Velocities = new ArrayList();
  ArrayList k3Forces = new ArrayList();
  ArrayList k3Velocities = new ArrayList();
  ArrayList k4Forces = new ArrayList();
  ArrayList k4Velocities = new ArrayList();
  ParticleSystem s;

  public RungeKuttaIntegrator( ParticleSystem s ) { this.s = s;  }
  
  final void allocateParticles()
  {
    while( s.particles.size() > originalPositions.size() ) {
        originalPositions.add( new PVector() );
    originalVelocities.add( new PVector() );
    k1Forces.add( new PVector() );
    k1Velocities.add( new PVector() );
    k2Forces.add( new PVector() );
    k2Velocities.add( new PVector() );
    k3Forces.add( new PVector() );
    k3Velocities.add( new PVector() );
    k4Forces.add( new PVector() );
    k4Velocities.add( new PVector() );
    }
  }
  
  private final void setIntermediate(ArrayList forces, ArrayList velocities) {
    s.applyForces();
    for ( int i = 0; i < s.particles.size(); ++i )
      {
  Particle p = (Particle)s.particles.get( i );
  if ( p.isFree() )
    {
      ((PVector)forces.get( i )).set( p.force.x, p.force.y, p.force.z );
      ((PVector)velocities.get( i )).set( p.velocity.x, p.velocity.y, p.velocity.z );
            p.force.set(0f,0f,0f);
    }
      }
  }
  
  private final void updateIntermediate(ArrayList forces, ArrayList velocities, float multiplier) {
    PVector holder = new PVector();
    
    for ( int i = 0; i < s.particles.size(); ++i )
      {
  Particle p = (Particle)s.particles.get( i );
  if ( p.isFree() )
    {
        PVector op = (PVector)(originalPositions.get( i ));
            p.position.set(op.x, op.y, op.z);
            p.position.add(PVector.mult((PVector)(velocities.get( i )), multiplier, holder));    
      PVector ov = (PVector)(originalVelocities.get( i ));
            p.velocity.set(ov.x, ov.y, ov.z);
            p.velocity.add(PVector.mult((PVector)(forces.get( i )), multiplier/p.mass0, holder));  
          }
       }
  }
  
  private final void initialize() {
    for ( int i = 0; i < s.particles.size(); ++i )
      {
  Particle p = (Particle)(s.particles.get( i ));
  if ( p.isFree() )
    {    
      ((PVector)(originalPositions.get( i ))).set( p.position.x, p.position.y, p.position.z );
      ((PVector)(originalVelocities.get( i ))).set( p.velocity.x, p.velocity.y, p.velocity.z );
    }
  p.force.set(0f,0f,0f);  // and clear the forces
      }
  }
  
  public final void step( float deltaT )
  {  
    allocateParticles();
    initialize();       
    setIntermediate(k1Forces, k1Velocities);
    updateIntermediate(k1Forces, k1Velocities, 0.5f*deltaT );
    setIntermediate(k2Forces, k2Velocities);
    updateIntermediate(k2Forces, k2Velocities, 0.5f*deltaT );
    setIntermediate(k3Forces, k3Velocities);
    updateIntermediate(k3Forces, k3Velocities, deltaT );
    setIntermediate(k4Forces, k4Velocities);
    
    /////////////////////////////////////////////////////////////
    // put them all together and what do you get?
    for ( int i = 0; i < s.particles.size(); ++i )
      {
  Particle p = (Particle)s.particles.get( i );
  p.age0 += deltaT;
  if ( p.isFree() )
    {
      // update position
      PVector holder = (PVector)(k2Velocities.get( i ));
            holder.add((PVector)k3Velocities.get( i ));
            holder.mult(2.0f);
            holder.add((PVector)k1Velocities.get( i ));
            holder.add((PVector)k4Velocities.get( i ));
            holder.mult(deltaT / 6.0f);
            holder.add((PVector)originalPositions.get( i ));
            p.position.set(holder.x, holder.y, holder.z);
                          
      // update velocity
      holder = (PVector)k2Forces.get( i );
      holder.add((PVector)k3Forces.get( i ));
            holder.mult(2.0f);
            holder.add((PVector)k1Forces.get( i ));
            holder.add((PVector)k4Forces.get( i ));
            holder.mult(deltaT / (6.0f * p.mass0 ));
            holder.add((PVector)originalVelocities.get( i ));
      p.velocity.set(holder.x, holder.y, holder.z);
    }
      }
  }
} // RungeKuttaIntegrator

//===========================================================================================
//                                         Spring
//===========================================================================================
// May 29, 2005
//package traer.physics;
// @author jeffrey traer bernstein
public class Spring implements Force
{
  float springConstant0;
  float damping0;
  float restLength0;
  Particle one, b;
  boolean on = true;
    
  public Spring( Particle A, Particle B, float ks, float d, float r )
  {
    springConstant0 = ks;
    damping0 = d;
    restLength0 = r;
    one = A;
    b = B;
  }
  
  public final void     turnOff()                { on = false; }
  public final void     turnOn()                 { on = true; }
  public final boolean  isOn()                   { return on; }
  public final boolean  isOff()                  { return !on; }
  public final Particle getOneEnd()              { return one; }
  public final Particle getTheOtherEnd()         { return b; }
  public final float    currentLength()          { return one.distanceTo( b ); }
  public final float    restLength()             { return restLength0; }
  public final float    strength()               { return springConstant0; }
  public final void     setStrength( float ks )  { springConstant0 = ks; }
  public final float    damping()                { return damping0; }
  public final void     setDamping( float d )    { damping0 = d; }
  public final void     setRestLength( float l ) { restLength0 = l; }
  
  public final void apply()
  {  
    if ( on && ( one.isFree() || b.isFree() ) )
      {
        PVector a2b = PVector.sub(one.position, b.position, new PVector());

        float a2bDistance = a2b.mag();  
  
  if (a2bDistance!=0f) {
          a2b.div(a2bDistance);
        }

  // spring force is proportional to how much it stretched 
  float springForce = -( a2bDistance - restLength0 ) * springConstant0; 
  
        PVector vDamping = PVector.sub(one.velocity, b.velocity, new PVector());
        
        float dampingForce = -damping0 * a2b.dot(vDamping);
                           
  // forceB is same as forceA in opposite direction
  float r = springForce + dampingForce;
    
  a2b.mult(r);
      
  if ( one.isFree() )
     one.force.add( a2b );
  if ( b.isFree() )
     b.force.add( PVector.mult(a2b, -1, a2b) );
      }
  }
  protected void setA( Particle p ) { one = p; }
  protected void setB( Particle p ) { b = p; }
} // Spring

//===========================================================================================
//                                       Smoother
//===========================================================================================
//package traer.animator;
public class Smoother implements Tickable
{
  public Smoother(float smoothness)                     { setSmoothness(smoothness);  setValue(0.0F); }
  public Smoother(float smoothness, float start)        { setSmoothness(smoothness); setValue(start); }
  public final void     setSmoothness(float smoothness) { a = -smoothness; gain = 1.0F + a; }
  public final void     setTarget(float target)         { input = target; }
  public void           setValue(float x)               { input = x; lastOutput = x; }
  public final float    getTarget()                     { return input; }
  public final void     tick()                          { lastOutput = gain * input - a * lastOutput; }
  public final float    getValue()                      { return lastOutput; }
  public float a, gain, lastOutput, input;
} // Smoother

//===========================================================================================
//                                      Smoother3D
//===========================================================================================
//package traer.animator;
public class Smoother3D implements Tickable
{
  public Smoother3D(float smoothness)
  {
    x0 = new Smoother(smoothness);
    y0 = new Smoother(smoothness);
    z0 = new Smoother(smoothness);
  }
  public Smoother3D(float initialX, float initialY, float initialZ, float smoothness)
  {
    x0 = new Smoother(smoothness, initialX);
    y0 = new Smoother(smoothness, initialY);
    z0 = new Smoother(smoothness, initialZ);
  }
  public final void setXTarget(float X) { x0.setTarget(X); }
  public final void setYTarget(float X) { y0.setTarget(X); }
  public final void setZTarget(float X) { z0.setTarget(X); }
  public final float getXTarget()       { return x0.getTarget(); }
  public final float getYTarget()       { return y0.getTarget(); }
  public final float getZTarget()       { return z0.getTarget(); }
  public final void setTarget(float X, float Y, float Z)
  {
    x0.setTarget(X);
    y0.setTarget(Y);
    z0.setTarget(Z);
  }
  public final void setValue(float X, float Y, float Z)
  {
    x0.setValue(X);
    y0.setValue(Y);
    z0.setValue(Z);
  }
  public final void setX(float X)  { x0.setValue(X); }
  public final void setY(float Y)  { y0.setValue(Y); }
  public final void setZ(float Z)  { z0.setValue(Z); }
  public final void setSmoothness(float smoothness)
  {
    x0.setSmoothness(smoothness);
    y0.setSmoothness(smoothness);
    z0.setSmoothness(smoothness);
  }
  public final void tick()         { x0.tick(); y0.tick(); z0.tick(); }
  public final float x()           { return x0.getValue(); }
  public final float y()           { return y0.getValue(); }
  public final float z()           { return z0.getValue(); }
  public Smoother x0, y0, z0;
} // Smoother3D

//===========================================================================================
//                                      Tickable
//===========================================================================================
//package traer.animator;
public interface Tickable
{
  public abstract void tick();
  public abstract void setSmoothness(float f);
} // Tickable

// Code by George Profenza https://stackoverflow.com/users/89766/george-profenza
// https://stackoverflow.com/questions/56999816/is-it-possible-to-use-jcsg-library-with-processing

PShape csgResult; // PShape for the converted polys

void setup() {
  size(600, 500, P3D);
  noStroke();
  // from JCSG sample code:
  // cube and sphere as base geometries
  CSG cube = new Cube(2).toCSG();
  CSG sphere = new Sphere(1.25).toCSG();

  // perform union, difference and intersection
  CSG cubePlusSphere = cube.union(sphere);
  CSG cubeMinusSphere = cube.difference(sphere);
  CSG cubeIntersectSphere = cube.intersect(sphere);

  // translate geometries to prevent overlapping, and add to a list.
  ArrayList<CSG> objects = new ArrayList();
  objects.add(sphere.transformed(transX(3))); 
  objects.add(cubePlusSphere.transformed(transX(6)));
  objects.add(cubeMinusSphere.transformed(transX(9))); 
  objects.add(cubeIntersectSphere.transformed(transX(12)));

  CSG union = cube.union(objects);
  union = union.transformed(transX(-6)); // translate back
  csgResult = CSGToPShape(union, 45);
}

// re-usable function to convert a CSG mesh to a Processing PShape
PShape CSGToPShape(CSG mesh, float scale) {
  // allocate a PShape group
  PShape csgResult = createShape(GROUP);
  // for each CSG polygon (Note: these can have 3,4 or more vertices)
  for (Polygon p : mesh.getPolygons()) {
    // make a child PShape
    PShape polyShape = createShape();
    // begin setting vertices to it
    polyShape.beginShape();
    // for each vertex in the polygon
    for (Vertex v : p.vertices) {
      // add each (scaled) polygon vertex 
      polyShape.vertex((float)v.pos.getX() * scale, (float)v.pos.getY() * scale, (float)v.pos.getZ() * scale);
    }
    // finish this polygon
    polyShape.endShape();
    //append the child PShape to the parent
    csgResult.addChild(polyShape);
  }
  return csgResult;
}

Transform tRotate(float x, float y, float z) {
  return Transform.unity().rot(x, y, z);
}

Transform transX(float x) {
  return Transform.unity().translateX(x);
}

void draw() {
  background(0);
  lights();
  translate(width * 0.5, height * 0.5, 0);
  rotateY(map(mouseX, 0, width, -PI, PI));
  rotateX(map(mouseY, 0, height, PI, -PI));
  shape(csgResult);
}

void keyPressed() {
  saveFrame("###.png");
}

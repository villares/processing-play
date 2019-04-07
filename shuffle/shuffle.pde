// Native "shuffle" for Java ArrayLists

import java.util.Collections;
ArrayList<String> coisas;

void setup(){
coisas = new ArrayList<String>();
coisas.add("a");
coisas.add("b");
coisas.add("c");
coisas.add("d");
println(coisas);
}

void draw(){
}

void keyPressed(){
  // Shuffle do Java!
  Collections.shuffle(coisas);
  println(coisas);
  // bonus: ArrayList contains() method!
  println(coisas.contains("a"));
}


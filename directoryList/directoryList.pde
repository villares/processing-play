void setup() {
  String path = sketchPath("data");
  //String path = sketchPath(); // default é a pasta do sketch
  String[] filenames = listFileNames(path);
  printArray(filenames);
}

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

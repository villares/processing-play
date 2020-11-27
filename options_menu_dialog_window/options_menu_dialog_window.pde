import javax.swing.*;

Object[] possibilities = {"60 FPS", "50 FPS", "40 FPS", "30 FPS", "15 FPS"};

void setup() {
  size(400, 300);
  
  String s = (String)JOptionPane.showInputDialog(
                     null, // could be 'frame' 
                     "Please choose frame rate for image capture:", 
                     "Choose frame rate", 
                     JOptionPane.WARNING_MESSAGE, 
                     null, // return 'null' on Cancel 
                     possibilities, 
                     "60 FPS");

  if (s != null) {
    println(s);
  } else {
    println("Cancelled");
  }
}

void draw()
{
  background(0);
} 

import javax.swing.*;
Object[] possibilities = {"60 FPS", "50 FPS", "40 FPS", "30 FPS", "15 FPS"};

void setup()
{
 size(400, 300,P2D);
 String s = (String)JOptionPane.showInputDialog(
                   frame,
                   "Please choose frame rate for image capture:",
                   "Choose frame rate",
                   JOptionPane.WARNING_MESSAGE,
                   null,
                   possibilities,
                   "60 FPS");
}

void draw()
{} 

void setup() {
  // JTextField ta = new JTextField();     // text field alternative
  JTextArea ta = new JTextArea(20, 20);    // text area
  ta.setText("Default text");
  Object[] options = {"Yes, please",       // 0
                      "No, thanks",        // 1
                      "No eggs, no ham!"}; // 2
                                  // cancel: -1
  int n = JOptionPane.showOptionDialog(null,
                                      new JScrollPane(ta), 
                                      // or you can use just "ta", without scroll bars
                                      "A Silly Question",  // title
                                      JOptionPane.YES_NO_CANCEL_OPTION, 
                                      JOptionPane.QUESTION_MESSAGE, 
                                      null, 
                                      options, 
                                      options[2]);
  println(n);
  println("text: " + ta.getText());
}

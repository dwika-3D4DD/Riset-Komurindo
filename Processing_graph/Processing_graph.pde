import processing.serial.*;

Serial port;
int xPos = 1;
float inByte = 0;

void setup() {
  size (400, 300);
  println (Serial.list());
  port = new Serial (this, Serial.list()[0], 9600);
  port.bufferUntil('\n');
  background (0);
}

void draw() {
  //draw lines
  stroke (#F0DD0C);
  line (xPos, height, xPos, height - inByte);

  //at the edge of the screen, go back to the beginning
  if (xPos >= width) {
    xPos = 0;
    background (0);
  } else {
    xPos++;
  }
}

void serialEvent (Serial port) {
  //get the ASCII string
  String inString = port.readStringUntil('\n');

  if (inString != null) {
    //trim off any whitespace
    inString = trim (inString);
    //convert to an int and map to the screen height
    inByte = float (inString);
    println (inByte);
    inByte = map (inByte, 0, 1023, 0, height);
  }
}

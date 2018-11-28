import processing.serial.*;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

TypingText typingText = new TypingText(100, 20);
DrawAndFill drawAndFill = new DrawAndFill();

Serial port;
PrintWriter pressure_data_writer;
final Integer pin_sum = 8;
public Integer pin = 0;
public ArrayList<Integer> fingerPointX = new ArrayList<Integer>();
public ArrayList<Integer> fingerPointY = new ArrayList<Integer>();
public HashMap<String, Integer> keyNameandPointXMap = new HashMap<String, Integer>();
public HashMap<String, Integer> keyNameandPointYMap = new HashMap<String, Integer>();
//public Integer pointX, pointY;


void setup() {
  port = new Serial(this, Serial.list()[1], 9600);
  pressure_data_writer = createWriter("data.text");
  size(800, 320);
  background(255);
  stroke(0);
  drawAndFill.drawKeyAndFinger(fingerPointX, fingerPointY);
  typingText.setUpKeyTypeFinger();
  typingText.loadText();
  fill(0);
  port.clear();
}

void draw() {
  portDataRead();
}

void portDataRead() {
  if (port.available() > pin_sum) {
    if (port.read() == 'a' && keyPressed) {
      pressureDataWriter(key);
    }
    port.clear();
  }
}

void pressureDataWriter(char typekey) {
  Integer pressureData;
  pressure_data_writer.println(typekey);
  for (Integer i = 0; i < pin_sum; i++) {
    pressureData = port.read();
    drawAndFill.fillFinger(pressureData, i);
    pressure_data_writer.println("pin" + i + ":" + pressureData);
  }
  pressure_data_writer.println();
}



void keyPressed() {
  if (key == ENTER) {
    this.endProgram();
  } else if (key != ENTER) {
    typingText.fillText(key);
    drawAndFill.fillKey(key);
  }
}

void endProgram() {
  pressure_data_writer.flush();
  pressure_data_writer.close();
  exit();
}

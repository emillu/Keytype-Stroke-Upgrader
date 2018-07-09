import processing.serial.*;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

Serial port;
PrintWriter pressure_data_writer;
final Integer pin_sum = 8;
final String[] keyNames = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/"};
HashMap<String, Integer> keyNameandPointXMap = new HashMap<String, Integer>();
HashMap<String, Integer> keyNameandPointYMap = new HashMap<String, Integer>();
ArrayList<Integer> fingerPointX = new ArrayList<Integer>();
ArrayList<Integer> fingerPointY = new ArrayList<Integer>();
Integer pointX, pointY;


void setup() {
  port = new Serial(this, Serial.list()[1], 9600);
  pressure_data_writer = createWriter("data.text");
  size(800, 320);
  background(255);
  stroke(0);
  drawKeybord();
  drawFinger(200, 1);
  drawFinger(600, -1);
  fill(0);
  port.clear();
}

void drawFinger(Integer pointX, Integer handSide) {
  Integer[] fingerHeigh = {0, 20, 40, 20};
  for (Integer i = 0; i < 4; i++) {
    ellipse(pointX+(30*(handSide*i)), 370-fingerHeigh[i], 30, 200);
    fingerPointX.add(pointX+(30*(handSide*i)));
    fingerPointY.add(370-fingerHeigh[i]);
  }
}

void drawKeybord() {
  Integer keyNumber;
  for (Integer y = 1; y < 4; y++) {
    pointY = 55*y;
    for (Integer x = 0; x < 10; x++) {
      pointX = 100+50*x+10*y;
      keyNumber = x+10*(y-1);
      rect(pointX, pointY, 50, 50);
      fill(0);
      text(keyNames[keyNumber], pointX+15, pointY+30);
      fill(255);
      keyNameandPointXMap.put(keyNames[keyNumber], pointX);
      keyNameandPointYMap.put(keyNames[keyNumber], pointY);
    }
  }
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
    fillFinger(pressureData, i);
    pressure_data_writer.println("pin" + i + ":" + pressureData);
  }
  pressure_data_writer.println();
}

void fillFinger(Integer pressureData, Integer pinNumber) {
  fill(255);
  ellipse(fingerPointX.get(7-pinNumber), fingerPointY.get(7-pinNumber), 30, 200);
  stroke(0);
  if(pressureData != 255 && pressureData >= 150)  fill(255, 0, 0);
  else if(pressureData < 150) errorMessagePrint(pinNumber);
  ellipse(fingerPointX.get(7-pinNumber), fingerPointY.get(7-pinNumber), 30, 200);
}

void fillKey(char typekey) {
  noFill();
  stroke(255);
  if (pointX != null && pointY != null) {
    rect(pointX+5, pointY+10, 30, 30);
  }
  pointX = keyNameandPointXMap.get((String.valueOf(typekey).toUpperCase()));
  pointY = keyNameandPointYMap.get((String.valueOf(typekey).toUpperCase()));
  stroke(255, 0, 0);
  if (pointX != null && pointY != null) {  
    rect(pointX+5, pointY+10, 30, 30);
  }
}

void errorMessagePrint(Integer pinNumber){
  background(255);
  text(pinNumber + "番ピンでエラーが発生しました。接続を確認して実行し直してください", 200, 200);
  noLoop();
}

void keyPressed() {
  if (key == ENTER) {
    pressure_data_writer.flush();
    pressure_data_writer.close();
    exit();
  } else if (key != ENTER) {
    fillKey(key);
  }
}

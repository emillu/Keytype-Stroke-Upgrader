class DrawAndFill{

  DrawKeyAndFinger drawKeyAndFinger = new DrawKeyAndFinger();
  private Integer pointX, pointY;
  
  void drawKeyAndFinger(ArrayList<Integer> fingerPointX, ArrayList<Integer> fingerPointY){
    drawKeyAndFinger.drawFinger(200, 1, fingerPointX, fingerPointY);
    drawKeyAndFinger.drawFinger(600, -1, fingerPointX, fingerPointY);
    drawKeyAndFinger.drawKeybord();
  }
  
  void fillFinger(Integer pressureData, Integer pinNumber) {
    fill(255);
    ellipse(fingerPointX.get(7-pinNumber), fingerPointY.get(7-pinNumber), 30, 200);
    stroke(0);
    if(pressureData != 255 && pressureData >= 150)  {fill(255, 0, 0); pin = pinNumber;}
    //else if(pressureData < 150) errorMessagePrint(pinNumber);
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
  
}

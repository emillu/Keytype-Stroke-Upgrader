class DrawKeyAndFinger{
  
  final String[] keyNames = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/"};
  
  void drawFinger(Integer pointX, Integer handSide, ArrayList<Integer> fingerPointX, ArrayList<Integer> fingerPointY) {
    Integer[] fingerHeigh = {0, 20, 40, 20};
    for (Integer i = 0; i < 4; i++) {
      ellipse(pointX+(30*(handSide*i)), 370-fingerHeigh[i], 30, 200);
      fingerPointX.add(pointX+(30*(handSide*i)));
      fingerPointY.add(370-fingerHeigh[i]);
    }
  }
  
  void drawKeybord(){
      Integer keyNumber, pointX, pointY;
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
  
}

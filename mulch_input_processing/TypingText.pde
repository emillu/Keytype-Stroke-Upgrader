class TypingText{
  
  Integer printPointX, printPointY;
  final String FILE_NAME = "typingText.txt";
  
  TypingText(Integer pointX, Integer pointY){
    printPointX = pointX;
    printPointY = pointY;
  }
  
  void printText(){
    PFont typeTextFont = createFont("Yu Gothic", 20, true);
    String[] wordData = loadStrings(FILE_NAME);
    fill(0);
    textFont(typeTextFont);
    text(wordData[0], printPointX, printPointY);
    fill(255);
  }
}

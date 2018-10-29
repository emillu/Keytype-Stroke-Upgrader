class TypingText{
  
  Integer printPointX, printPointY;
  final String FILE_NAME = "typingText.txt";
  private HashMap<String, Integer> fingerAndKeyMap = new HashMap<String, Integer>();
  private PFont typeTextFont;
  private String[] lineData;
  private Integer wordDataNumber = 0, lineDataNumber = 0;
  
  TypingText(Integer pointX, Integer pointY){
    printPointX = pointX;
    printPointY = pointY;
  }
  
  void setUpKeyTypeFinger(){
    final Integer[] keyTypeFingerNumbers = {7, 6, 5, 3, 3, 4, 4, 2, 1, 0};
    final String[] keyNames = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/"};
    for(Integer i = 0; i < keyNames.length-1; i++){
      fingerAndKeyMap.put(keyNames[i], keyTypeFingerNumbers[i%7]);
    }
  }
  
  void loadText(){
    typeTextFont = createFont("Yu Gothic", 20, true);
    lineData = append(loadStrings(FILE_NAME), "");
    this.printText();
  }
  
  void printText(){
   if(lineDataNumber == lineData.length-1){
     endProgram();      
    }
    wordDataNumber = 0;
    fill(0);
    textFont(typeTextFont);
    for(Integer i=0; i < lineData[lineDataNumber].length(); i++){
      text(lineData[lineDataNumber].split("")[i], printPointX+15*i, printPointY);
    }
    fill(255);
  }
  
  void printTextDelete(){
    stroke(255);
    fill(255);
    rect(printPointX, printPointY-20, 400, 40);
    stroke(0);
  }
  
  void fillText(char typeKey){
    String[] wordData = lineData[lineDataNumber].split("");
    Integer lineLength = lineData[lineDataNumber].length();
    fill(255, 0, 0);
     if((wordData[wordDataNumber].equals(String.valueOf(typeKey)) ||
     wordData[wordDataNumber].equals(String.valueOf(typeKey).toUpperCase())) &&
     (fingerAndKeyMap.get(String.valueOf(typeKey).toUpperCase()) == pin)){
       text(wordData[wordDataNumber], printPointX+wordDataNumber*15, printPointY);
       wordDataNumber++;
       if(lineLength == wordDataNumber){
         lineDataNumber++;
         this.printTextDelete();
         this.printText();
       }
     }
    fill(255);
  }
}

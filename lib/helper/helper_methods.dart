bool isWhite(int index){
  int x = index ~/ 8; // gives us row
  int y = index % 8; //gives us column

  //checkered pattern
  bool isWhite = (x+y)%2 == 0;

  return isWhite;
}
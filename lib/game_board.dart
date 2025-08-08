import 'package:chess_app/components/square.dart';
import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: 8 *8,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
          itemBuilder: (context, index) {
            int x = index ~/ 8; // gives us row
            int y = index % 8; //gives us column

            //checkered pattern
            bool isWhite = (x+y)%2 == 0;
            return Square(isWhite: isWhite);
          }
      ),
    );
  }

}

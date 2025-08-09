import 'package:chess_app/components/piece.dart';
import 'package:chess_app/components/square.dart';
import 'package:chess_app/helper/helper_methods.dart';
import 'package:chess_app/values/colors.dart';
import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  // A 2D list for teh chessboard,
  //each index its a piece

  late List<List<ChessPiece?>> board;

  @override
  void initState(){
    super.initState();
    _initializeBoard();
  }

  //initialize board
  void _initializeBoard(){
    //initialize board with nullsm each piece in coorect position

    List<List<ChessPiece?>> newBoard =
        List.generate(8, (index) => List.generate(8, (index) => null));

    //Pawn positions
    for(int i = 0; i< 8; i++){
      newBoard[1][i] = ChessPiece(
          type: ChessPieceType.pawn,
          isWhite: true,
          imagePath: 'lib/images/pawn.png'
      );

      newBoard[6][i] = ChessPiece(
          type: ChessPieceType.pawn,
          isWhite: false,
          imagePath: 'lib/images/pawn.png'
      );
    }

    //Rooks positions
    newBoard[0][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/rook.png'
    ) ;

    newBoard[7][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/rook.png'
    ) ;

    newBoard[7][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/rook.png'
    ) ;

    newBoard[0][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/rook.png'
    ) ;
    //Place knights

    //Place bishops

    //Place queens

    //Place kings

    board = newBoard;
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GridView.builder(
        itemCount: 8 *8,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
          itemBuilder: (context, index) {

          // row and column of this square
            int row = index ~/ 8; // gives us row
            int col = index % 8; //gives us column

            return Square(
                isWhite: isWhite(index),
                piece: board[row][col],
            );

          },
      ),
    );
  }

}

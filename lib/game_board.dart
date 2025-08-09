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

  ChessPiece? selectedPiece;
  //Row and column of the selected piece
  int selectedRow = -1;
  int selectedCol = -1;

  //list of valid moves for the currently selected piece
  //each move is depicted as a list with 2 elements: row and col;
  List<List<int>> validMoves = [];

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
          isWhite: false,
          imagePath: 'lib/images/pawn.png'
      );

      newBoard[6][i] = ChessPiece(
          type: ChessPieceType.pawn,
          isWhite: true,
          imagePath: 'lib/images/pawn.png'
      );
    }

    //Rooks positions
    newBoard[0][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/rook.png'
    ) ;

    newBoard[7][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/rook.png'
    ) ;

    newBoard[7][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/rook.png'
    ) ;

    newBoard[0][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/rook.png'
    ) ;


    //Place knights
    newBoard[0][1] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/knight.png'
    ) ;

    newBoard[0][6] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/knight.png'
    ) ;

    newBoard[7][1] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/knight.png'
    ) ;

    newBoard[7][6] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/knight.png'
    ) ;

    //Place bishops
    newBoard[0][2] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/bishop.png'
    ) ;

    newBoard[0][5] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/bishop.png'
    ) ;

    newBoard[7][2] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/bishop.png'
    ) ;

    newBoard[7][5] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/bishop.png'
    ) ;

    //Place queens
    newBoard[0][3] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/queen.png'
    ) ;

    newBoard[7][4] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/queen.png'
    ) ;
    //Place kings
    newBoard[0][4] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/king.png'
    ) ;

    newBoard[7][3] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/king.png'
    ) ;

    board = newBoard;
  }


//selected piece by the user
  void pieceSelected(int row, int col){
    setState(() {
      //selected a piece if the piece is in a that position
      if(board[row][col] != null){
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }

      //valid moves calculations
      validMoves =
          calculateRawValidMoves(selectedRow, selectedCol, selectedPiece);
    });
  }

  //calcuation of raw and valid moves
  List<List<int>> calculateRawValidMoves(int row, int col, ChessPiece? piece){
    List<List<int>> candidateMoves = [];
    //different directions based on their color
    int direction = piece!.isWhite ? -1 : 1;

    switch(piece.type){
      case ChessPieceType.pawn:
        //forward if square is not occupied
        if(isInBoard(row + direction, col) && board[row+direction][col] == null){
          candidateMoves.add([row + direction, col]);
        }
        //can move 2 square forwards if they are at the starting position
        if((row == 1 && !piece.isWhite) || (row == 6 && piece.isWhite)){
          if(isInBoard(row+2*direction, col) &&
              board[row+2*direction][col] == null &&
              board[row + direction][col] == null){
            candidateMoves.add([row + 2 * direction, col]);
          }
        }

        //can move diagonally-forward when capturing enemy pieces
        if(isInBoard(row+direction, col-1) &&
        board[row+direction][col -1] != null &&
        board[row+direction][col-1]!.isWhite){
          candidateMoves.add([row+direction, col-1]);
        }
        break;


      case ChessPieceType.rook:
        break;
      case ChessPieceType.knight:
        break;
      case ChessPieceType.bishop:
        break;
      case ChessPieceType.queen:
        break;
      case ChessPieceType.king:
        break;
      default:
    }

    return candidateMoves;
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

          //check if the square is selected or not
          bool isSelected = selectedRow == row && selectedCol == col;

          //check if the square is valid move or not
          bool isValidMove = false;
          for(var position in validMoves){
            //compare row and column
            if(position[0] == row && position[1] == col){
              isValidMove = true;
            }
          }

            return Square(
                isWhite: isWhite(index),
                piece: board[row][col],
                isSelected: isSelected,
                isValidMove: isValidMove,
                onTap: () => pieceSelected(row, col),

            );

          },
      ),
    );
  }

}

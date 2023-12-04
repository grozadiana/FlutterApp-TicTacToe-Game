import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  _TicTacToeGameState createState() {
    return _TicTacToeGameState();
  }
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<List<int>> board = List.generate(3, (_) => List<int>.filled(3, 0));
  int currentPlayer = 1;

  void _resetGame() {
    setState(() {
      board = List.generate(3, (_) => List<int>.filled(3, 0));
      currentPlayer = 1;
    });
  }

  void _onTilePressed(int row, int col) {
    if (board[row][col] == 0) {
      setState(() {
        board[row][col] = currentPlayer;
        if (_checkForWinner(row, col)) {
          _showWinnerDialog();
        } else {
          currentPlayer = (currentPlayer == 1) ? 2 : 1;
        }
      });
    }
  }

  bool _checkForWinner(int row, int col) {
    if (board[row].every((element) => element == currentPlayer)) {
      return true;
    }
    if (board.every((element) => element[col] == currentPlayer)) {
      return true;
    }
    if (row == col && board[0][0] == currentPlayer && board[1][1] == currentPlayer && board[2][2] == currentPlayer) {
      return true;
    }
    if (row + col == 2 &&
        board[0][2] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][0] == currentPlayer) {
      return true;
    }

    return false;
  }

  void _showWinnerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Player $currentPlayer wins!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int j = 0; j < 3; j++)
                    GestureDetector(
                      onTap: () => _onTilePressed(i, j),
                      child: Container(
                        width: 200,
                        height: 200,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: (board[i][j] == 1)
                              ? Colors.blue
                              : (board[i][j] == 2)
                                  ? Colors.red
                                  : Colors.grey,
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                          child: Text(
                            (board[i][j] == 1)
                                ? 'X'
                                : (board[i][j] == 2)
                                    ? 'O'
                                    : '',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ElevatedButton(
              onPressed: _resetGame,
              child: const Text('Reset Game'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TicTacToeProvider extends ChangeNotifier {
  bool gameOver = false;
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
  List<String>? board = List.generate(9, (index) => "");
  String value = "X";
  int turn = 0;
  String result = "";

  void winnerCheck(int index) {
    int row = index ~/ 3;
    int col = index % 3;
    int score = value == "X" ? 1 : -1;

    scoreboard[row] += score;
    scoreboard[3 + col] += score;
    if (row == col) scoreboard[2 * 3] += score;
    if (3 - 1 - col == row) scoreboard[2 * 3 + 1] += score;

    if (scoreboard.contains(3) || scoreboard.contains(-3)) {
      // print(true);
      gameOver = true;
      notifyListeners();
    }else{
      // print(scoreboard);
      // print(false);
      gameOver = false;
      notifyListeners();
    }
  }

  void checkWinner() {
    if (gameOver) {
      result = "$value is the Winner";
      // print(result);
      notifyListeners();
    } else if (!gameOver && turn == 9) {
      result = "It's a Draw!";
      gameOver = true;
      // print(result);
      notifyListeners();
    }
  }

  void checkLastValue() {
    if (value == "X") {
      value = "O";
      // print(value);
      notifyListeners();
    } else {
      value = "X";
      // print(value);
      notifyListeners();
    }
  }

  void restartGame() {
    board = List.generate(9, (index) => "");
    value = "X";
    gameOver = false;
    turn = 0;
    result = "";
    scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
    notifyListeners();
  }
}

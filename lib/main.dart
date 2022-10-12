import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/tictactoe_provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TicTacToeProvider(),
        builder: (context, _) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Tic Tac Toe",
            home: Main(),
          );
        });
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    final features = Provider.of<TicTacToeProvider>(context);

    final double width = (MediaQuery.of(context).size.height >=
            MediaQuery.of(context).size.width)
        ? MediaQuery.of(context).size.width
        : 500;
    final double height = (MediaQuery.of(context).size.height >=
            MediaQuery.of(context).size.width)
        ? MediaQuery.of(context).size.width
        : 500;

    return Scaffold(
        backgroundColor: const Color(0xff292d32),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Tic Tac Toe",
                  style: TextStyle(
                    color: features.value == "X"
                        ? const Color(0XFF48B5D5)
                        : const Color(0XFFF73668),
                    fontSize: 60,
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: width,
                  height: height,
                  child: GridView.count(
                    shrinkWrap: true,
                    childAspectRatio: (width / 3) / (height / 3),
                    crossAxisCount: 9 ~/ 3,
                    children: List.generate(9, (index) {
                      return Container(
                        width: width / 3,
                        height: height / 6,
                        decoration: boxdecoration(index),
                        child: InkWell(
                          onTap: features.gameOver
                              ? () => features.restartGame()
                              : () {
                                  debugPrint("width : $width");
                                  debugPrint("height : $height");
                                  debugPrint("container width : ${width / 3}");
                                  debugPrint(
                                      "container height : ${height / 3}");
                                  if (features.board![index] == "") {
                                    // print(features.board);
                                    // print("worked");
                                    features.board![index] = features.value;
                                    // print("count turn");
                                    // print(features.turn);
                                    features.turn++;
                                    // print(features.turn);
                                    features.winnerCheck(index);
                                    // print("checkWinner");
                                    features.checkWinner();
                                    // print("checkLastValue");
                                    features.checkLastValue();
                                    // print(features.board![index]);
                                  }
                                },
                          child: Center(
                            child: Text(
                              features.board![index],
                              style: TextStyle(
                                color: features.board![index] == "X"
                                    ? const Color(0XFF48B5D5)
                                    : const Color(0XFFF73668),
                                fontSize: 64,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  features.result == ""
                      ? "It's ${features.value} turn".toUpperCase()
                      : features.result,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  BoxDecoration boxdecoration(int index) {
    if (index == 3 || index == 5) {
      return const BoxDecoration(
          border: Border(
        top: BorderSide(color: Color(0XFF8C8C8C), width: 3),
        bottom: BorderSide(color: Color(0XFF8C8C8C), width: 3),
      ));
    } else if (index == 1 || index == 7) {
      return const BoxDecoration(
          border: Border(
        left: BorderSide(color: Color(0XFF8C8C8C), width: 3),
        right: BorderSide(color: Color(0XFF8C8C8C), width: 3),
      ));
    } else if (index == 4) {
      return BoxDecoration(
          border: Border.all(color: const Color(0XFF8C8C8C), width: 3));
    } else {
      return BoxDecoration(border: Border.all(color: Colors.transparent));
    }
  }
}

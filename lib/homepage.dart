import 'package:flutter/material.dart';

import 'game_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<GameButton> buttonList;
  List<int> player1 = [];
  List<int> player2 = [];
  int activePlayer = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonList = initializeGameButtons();
  }

  List<GameButton> initializeGameButtons() {
    return List<GameButton>.generate(9, (index) => GameButton(id: index + 1));
  }


  void playGame(GameButton gb){
    setState(() {
      if(activePlayer == 1){
        gb.text = "X";
        gb.bg= Colors.blue;
        activePlayer = 2;
        player1.add(gb.id);
      }else{
        gb.text = "O";
        gb.bg=Colors.black;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled =false;

      var winner = checkWinner();
      if (winner != -1) {
        showWinnerDialog(winner);
      }


    });

  }

  int checkWinner() {
    var winner = -1;

    List<List<int>> winningCombinations = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9],
      [1, 5, 9],
      [3, 5, 7],
    ];

    for (var combination in winningCombinations) {
      if (combination.every((element) => player1.contains(element))) {
        winner = 1;
        break;
      }
      if (combination.every((element) => player2.contains(element))) {
        winner = 2;
        break;
      }
    }
    return winner;
  }

  void showWinnerDialog(int winner) {
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return AlertDialog(
         title: Text("Cheek tapk dum dum..."),
         content: Text("Player $winner has won the game!"),
         actions: [
           TextButton(
             child: Text("Reset"),
             onPressed: () {
               Navigator.of(context).pop();
               resetGame();
             },
           ),
         ],
       );
     },
   );
 }

 void resetGame() {
   setState(() {
     buttonList = initializeGameButtons();
     player1 = [];
     player2 = [];
     activePlayer = 1;
   });
 }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Tic Tac Toe",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xfff6921e), Color(0xffee4036)])),
                child: Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 6.0,
                          mainAxisSpacing: 9.0),
                      itemCount:buttonList.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            child:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: buttonList[index].enabled?()=> playGame(buttonList[index]):null,
                                child: Text(buttonList[index].text,style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                                ),
                                style: ElevatedButton.styleFrom(
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(10)
                                   ),
                                    backgroundColor: buttonList[index].bg,
                                    disabledBackgroundColor: buttonList[index].bg
                                ),
                              ),
                            )
                        );
                      }),
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              resetGame();
            }, child: Text("Reset",style: TextStyle(
              color: Colors.white,
            ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black
              ),
            ),
          ],
      ),
    );
  }
}

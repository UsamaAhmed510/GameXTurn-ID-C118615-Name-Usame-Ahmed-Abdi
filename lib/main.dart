
// ignore_for_file: prefer_const_constructors, duplicate_ignore


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pizza_assignment/ui/theme/color.dart';
import 'package:pizza_assignment/ui/theme/utils/game_logic.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({Key? key}):super(key: key);

  Widget build(BuildContext context){
    return MaterialApp(
      home: GameScreen(),
    );//MaterialApp
  }
}


class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //adding the neccessary variables
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0; //to check the draw
  String result = "";
  List<int> scoreboard = [0,0,0,0,0,0,0,0]; //the score are the for the diffrent combination of the game[Row1,2,3 col1,2,3,  diagonal1,2];

  //let declare a new game components

  Game game = Game();

  //lets initi the gameboard 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }
  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("It's ${lastValue} turn".toUpperCase(),
          style: TextStyle(color: Colors.white,fontSize: 58,
          ),
          ),
          SizedBox(height: 20.0,
          ),
          //now we will make the game board
          //but first we will create a game game class that will contains all the data and method that we will need
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardlenth ~/ 3, 
              // the ~/operator allows you to evide to integer and return an int as a result
              padding: EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardlenth, (index){
              return InkWell(
                onTap: gameOver
                 ?null 
                 : () {
                  //when we click we need to add new value to the board refresh the screen 
                  //we need also to toggle the player
                  //we need to apply the click only if the field is empty
                  //now lets create a button to repeat the game 
                  if(game.board![index] == ""){
                    setState(() {
                     game.board![index] = lastValue;
                     turn++;
                     gameOver = game.winnerCheck(
                      lastValue, index, scoreboard, 3);

                      if(gameOver){
                        result = "$lastValue is the winner";
                      }else if(!gameOver && turn ==9){
                        result = "Its a Draw!";
                        gameOver = true;
                      }
                     if(lastValue == "X") 
                     lastValue ="O"; 
                     else
                     lastValue = "X";
                  });
                  }
            
                },
                child: Container(
                  width: Game.blockSize,
                  height: Game.blockSize,
                  decoration: BoxDecoration(
                    color: MainColor.secondaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: Text(game.board![index], style: TextStyle(color: game.board![index] == "X"
                     ?Colors.blue
                     :Colors.pink,
                     fontSize: 64.0,
              
                     ),
                     ),
                    ),
                ),
              );
            }),
            ),
          ),
          SizedBox(
            height: 25.0,
            ),
          Text(
            result,
             style: TextStyle(color: Colors.white,fontSize: 54.0),
             ),
          ElevatedButton.icon(
            onPressed: (){
              setState(() {
                //erase the board
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn = 0;
                result = "";
                scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
             icon: Icon(Icons.replay),
             label: Text("Repeat the Game"),
             ),
          ],
          
        ));
    //the first step is organize our project folder structure

  }
}








import 'package:animalfrenzy/mainMenu.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

ChickenGame chickenGame = ChickenGame();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: chickenGame);
  }
}

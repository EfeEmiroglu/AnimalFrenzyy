import 'package:animalfrenzy/mainMenu.dart';
import 'package:animalfrenzy/widgets/overlays/pause_button.dart';
import 'package:animalfrenzy/widgets/overlays/pause_menu.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

ChickenGame chickenGame = ChickenGame();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // WillPopScope provides us a way to decide if
      // this widget should be poped or not when user
      // presses the back button.
      body: WillPopScope(
        onWillPop: () async => false,
        // GameWidget is useful to inject the underlying
        // widget of any class extending from Flame's Game class.
        child: GameWidget(
          game: chickenGame,
          // Initially only pause button overlay will be visible.
          initialActiveOverlays: const [PauseButton.ID],
          overlayBuilderMap: {
            PauseButton.ID: (BuildContext context, ChickenGame gameRef) =>
                PauseButton(
                  gameRef: gameRef,
                ),
            PauseMenu.ID: (BuildContext context, ChickenGame gameRef) =>
                PauseMenu(
                  gameRef: gameRef,
                ),
          },
        ),
      ),
    );
  }
}

import 'package:animalfrenzy/mainMenu.dart';
import 'package:animalfrenzy/widgets/overlays/pause_menu.dart';
import 'package:flutter/material.dart';

class PauseButton extends StatelessWidget {
  static const String ID = 'PauseButton';
  final ChickenGame gameRef;

  const PauseButton({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: TextButton(
        child: const Icon(
          Icons.pause_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          gameRef.pauseEngine();
          gameRef.overlays.add(PauseMenu.ID);
          gameRef.overlays.remove(PauseButton.ID);
        },
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animalfrenzy/mainMenu.dart';
import 'package:animalfrenzy/screens/homeMenu.dart';
import 'package:animalfrenzy/widgets/overlays/pause_button.dart';
import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  static const String ID = 'PauseMenu';
  final ChickenGame gameRef;

  const PauseMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              'Paused',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              backgroundColor: Color.fromARGB(255, 2, 92, 5),
            ),
            onPressed: () {
              gameRef.resumeEngine();
              gameRef.overlays.remove(PauseMenu.ID);
              gameRef.overlays.add(PauseButton.ID);
            },
            child: Text(
              'Resume',
              style: TextStyle(color: Colors.white),
            ),
          ),
          //Reset Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              backgroundColor: Color.fromARGB(255, 2, 92, 5),
            ),
            onPressed: () {
              gameRef.resumeEngine();
              gameRef.overlays.remove(PauseMenu.ID);
              gameRef.overlays.add(PauseButton.ID);
              gameRef.reset();
              gameRef.resumeEngine();
            },
            child: Text(
              'Reset',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                backgroundColor: const Color.fromARGB(255, 2, 92, 5),
              ),
              onPressed: () {
                gameRef.overlays.remove(PauseMenu.ID);
                gameRef.reset();
                gameRef.resumeEngine();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainMenu(),
                  ),
                );
              },
              child: const Text('Exit')),
        ],
      ),
    );
  }
}

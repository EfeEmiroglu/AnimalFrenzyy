import 'package:animalfrenzy/screens/gamePlay.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              'Animal Frenzy',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 50.0,
                  shadows: [
                    const Shadow(
                        blurRadius: 20.0,
                        color: Colors.white,
                        offset: Offset(100, 0))
                  ]),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const GamePlay(),
                  ),
                );
              },
              child: Text('Play')),
          ElevatedButton(onPressed: () {}, child: Text('Options')),
        ]),
      ),
    );
  }
}

import 'package:animalfrenzy/screens/homeMenu.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/player_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.device.fullScreen();

  runApp(ChangeNotifierProvider(
      create: (context) => PlayerData.fromMap(PlayerData.defaultData),
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        // Use custom theme with 'BungeeInline' font.
        darkTheme:
            ThemeData(brightness: Brightness.dark, fontFamily: 'BungeeInline'),
        home: const MainMenu(),
      )));
}

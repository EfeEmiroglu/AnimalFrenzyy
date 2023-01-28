import 'package:animalfrenzy/screens/homeMenu.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.device.fullScreen();

  runApp(MaterialApp(
    themeMode: ThemeMode.dark,
    // Use custom theme with 'BungeeInline' font.
    darkTheme:
        ThemeData(brightness: Brightness.dark, fontFamily: 'BungeeInline'),
    home: const MainMenu(),
  ));
}

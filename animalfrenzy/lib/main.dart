import 'package:animalfrenzy/screens/homeMenu.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.device.fullScreen();

  runApp(MaterialApp(
    themeMode: ThemeMode.dark,
    darkTheme: ThemeData.dark().copyWith(
      textTheme: GoogleFonts.bungeeHairlineTextTheme(),
      scaffoldBackgroundColor: Colors.black,
    ),
    home: const MainMenu(),
  ));
}

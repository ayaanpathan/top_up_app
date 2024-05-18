import 'package:flutter/material.dart';

class ThemeProvider {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF06768d),
    hintColor: const Color(0xFF7cafd1),
    cardColor: Colors.grey[800],
    scaffoldBackgroundColor: Colors.grey[900],
    dividerColor: Colors.white70,
    iconTheme: IconThemeData(color: Colors.blue[600]),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFb3aae2),
      ),
    ),
  );
}

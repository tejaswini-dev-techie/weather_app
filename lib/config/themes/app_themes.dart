import 'package:flutter/material.dart';

class AppTheme {
  static const Color lightBackgroundColor = Color(0xfff2f2f2);
  static const Color lightPrimaryColor = Color(0xfff2f2f2);
  static Color lightAccentColor = Colors.blueGrey.shade200;
  static const Color lightParticlesColor = Color(0x44948282);

  static const Color darkBackgroundColor = Color(0xFF1A2127);
  static const Color darkPrimaryColor = Color(0xFF1A2127);
  static Color darkAccentColor = Colors.blueGrey.shade600;
  static const Color darkParticlesColor = Color(0x441C2A3D);

  const AppTheme._();
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

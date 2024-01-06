import 'package:flutter/material.dart';

class AppTheme {

  theme() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.deepPurple,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    )
  );
}
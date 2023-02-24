import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;
  ThemeData themeData = ThemeData.light();
  void toggleTheme() {
    if (isDarkMode) {
      themeData = ThemeData.dark()
          .copyWith(appBarTheme: const AppBarTheme(elevation: 0.0));
    } else {
      themeData = ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(elevation: 0.0));
    }
    notifyListeners();
  }
}

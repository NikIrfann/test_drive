import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  String statusMode = 'Light';
  bool isDarkMode = false;
  Locale currentLocale = const Locale('en'); // Add this line to store the current locale

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    if (isDarkMode) {
      statusMode = 'Dark';
    } else {
      statusMode = 'Light';
    }
    notifyListeners();
  }

  // Method to update the current locale
  void updateLocale(Locale locale) {
    currentLocale = locale;
    notifyListeners();
  }
}

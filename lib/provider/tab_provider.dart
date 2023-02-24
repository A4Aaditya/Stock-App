import 'package:flutter/material.dart';

class TabProvider extends ChangeNotifier {
  int index = 0;

  void onTap(int tabIndex) {
    index = tabIndex;
    notifyListeners();
  }
}

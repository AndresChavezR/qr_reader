import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  int _selectMenuOpt = 0;
  int get selectMenuOpt => _selectMenuOpt;
  set selectMenuOpt(int value) {
    _selectMenuOpt = value;
    notifyListeners();
  }
}

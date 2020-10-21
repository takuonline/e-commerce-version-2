import 'package:flutter/material.dart';



class BottomNavIndex with ChangeNotifier {
  int _bottomNavIndex = 0;
  int  get bottomNavIndex => _bottomNavIndex;

  void setBottomNavIndex(int value) {
    _bottomNavIndex = value;
    notifyListeners();
  }
}
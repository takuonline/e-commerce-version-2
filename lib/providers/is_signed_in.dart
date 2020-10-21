import 'package:flutter/material.dart';



class IsLoggedIn with ChangeNotifier {
  bool _isLoggedIn = false;
  bool  get isLoggedIn => _isLoggedIn;

  void setIsLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}
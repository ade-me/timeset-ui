import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoggedin = false;

  void changeLoggedInState() {
    isLoggedin = !isLoggedin;
    notifyListeners();
  }
}

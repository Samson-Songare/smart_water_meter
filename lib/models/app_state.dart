import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  bool _isLoggedIn = false;
  String _phoneCode = '';

  bool get isLoggedIn => _isLoggedIn;
  String get phoneCode => _phoneCode;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void setPhoneCode(String code) {
    _phoneCode = code;
    notifyListeners();
  }
}

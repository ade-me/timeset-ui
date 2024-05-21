import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref with ChangeNotifier {
  final String _authTokenKey = 'authToken';

  String _authToken = '';
  String get authToken => _authToken;

  Future<SharedPreferences> getSharedInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences;
  }

  Future<void> initSharedPref() async {
    await getSharedInstance();
  }

  Future<void> setAuthToken(String authToken) async {
    SharedPreferences prefs = await getSharedInstance();

    await prefs.setString(_authTokenKey, authToken);
  }

  Future<void> getAuthToken() async {
    SharedPreferences prefs = await getSharedInstance();

    _authToken = prefs.getString(_authTokenKey) ?? '';

    notifyListeners();
  }
}

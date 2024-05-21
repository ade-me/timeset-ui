// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_scaffold_messenger.dart';
import '../helpers/show_custom_loader.dart';
import '../repositories/auth_repo.dart';
import '../screens/home_screen.dart';
import 'shared_pref.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _changeLoggedInState(bool status) {
    _isLoggedIn = status;

    notifyListeners();
  }

  void _changeLoadingState(bool status) {
    _isLoading = status;

    notifyListeners();
  }

  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      _changeLoadingState(true);
      showCustomLoader(context);

      Response response =
          await AuthRepo.login(email: email, password: password);

      dynamic body = jsonDecode(response.body);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        _changeLoggedInState(true);
        if (context.mounted) {
          var sharedPref = Provider.of<SharedPref>(context, listen: false);

          await sharedPref.setAuthToken(body['token'].toString());
        }

        _changeLoadingState(false);

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        }
      } else {
        print('Error logging user in: ${body['message']}');
        _changeLoadingState(false);
        if (context.mounted) {
          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            textContent: body['message'].toString(),
            context: context,
          );

          Navigator.pop(context);
        }
      }
    } catch (e) {
      print('Error logging user in: $e');
      _changeLoadingState(false);
      if (context.mounted) {
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'An error occured, please try again.',
          context: context,
        );

        Navigator.pop(context);
      }
    }
  }
}

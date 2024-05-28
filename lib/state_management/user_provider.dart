// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_scaffold_messenger.dart';
import '../helpers/show_custom_loader.dart';
import '../repositories/user_repo.dart';
import '../screens/home_screen.dart';
import 'shared_pref.dart';

class UserProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _changeLoadingState(bool status) {
    _isLoading = status;

    notifyListeners();
  }

  Future<void> updateUserProfile({
    required BuildContext context,
    required Map<String, dynamic> body,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      _changeLoadingState(true);
      await Future.delayed(Duration.zero, () async {
        if (context.mounted) showCustomLoader(context);
      });

      Response response = await UserRepo.updateUserProfile(
        data: body,
      );

      int statusCode = response.statusCode;
      dynamic data = jsonDecode(response.body);

      print(data);

      if (statusCode == 201) {
        print(data);
        if (context.mounted) {
          await Future.delayed(Duration.zero, () async {
            var sharedPref = Provider.of<SharedPref>(context, listen: false);
            await sharedPref.setAuthToken(body['token'].toString());
          });
        }

        _changeLoadingState(false);

        if (context.mounted) {
          await Future.delayed(Duration.zero, () {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          });
        }
      } else {
        List<dynamic> messages = data['messages'] as List<dynamic>;
        String message = messages.first.toString();
        print('Error updating user profile: $message');
        _changeLoadingState(false);
        if (context.mounted) {
          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            textContent: message,
            context: context,
          );

          Navigator.pop(context);
        }
      }
    } catch (e) {
      print('Error updating user profile: $e');
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

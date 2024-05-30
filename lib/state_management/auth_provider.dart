// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_scaffold_messenger.dart';
import '../helpers/show_custom_loader.dart';
import '../repositories/auth_repo.dart';
import '../screens/auth/create_new_password_screen.dart';
import '../screens/auth/fill_profile_screen.dart';
import '../screens/home_screen.dart';
import '../widgets/general_widgets/custom_message_bottom_sheet.dart';
import 'shared_pref.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Map<String, dynamic>? _forgottenUserDetails;
  Map<String, dynamic>? get forgottenUserDetails => _forgottenUserDetails;

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
        // List<dynamic> message = body['message'] as List<dynamic>;

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

  Future<void> createUser({
    required String email,
    required String password,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      _changeLoadingState(true);
      showCustomLoader(context);

      Response response =
          await AuthRepo.signUp(email: email, password: password);

      dynamic body = jsonDecode(response.body);
      int statusCode = response.statusCode;

      if (statusCode == 201 && body['success'] == true) {
        _changeLoggedInState(true);
        await _verifyEmail(email: email);

        if (context.mounted) {
          var sharedPref = Provider.of<SharedPref>(context, listen: false);

          await sharedPref.setAuthToken(body['token'].toString());
        }

        _changeLoadingState(false);

        if (context.mounted) {
          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            textContent: 'User created successfully',
            context: context,
            bkgColor: Colors.green,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            FillProfileScreen.routeName,
            ModalRoute.withName(HomeScreen.routeName),
          );
        }
      } else {
        List<dynamic> message = body['message'] as List<dynamic>;

        print('Error creating user in: ${body['message']}');
        _changeLoadingState(false);
        if (context.mounted) {
          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            textContent: message.first,
            context: context,
          );

          Navigator.pop(context);
        }
      }
    } catch (e) {
      print('Error creating user in: $e');
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

  Future<void> findUserWithEmail({
    required String email,
    required Function nextPage,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      showCustomLoader(context);

      Response response = await AuthRepo.findUserWithEmail(email: email);

      dynamic body = jsonDecode(response.body);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        String gEmail = body['email'].toString();
        String number = body['phone'].toString();

        _forgottenUserDetails = {
          'email': gEmail,
          'number': number,
        };

        if (context.mounted) {
          Navigator.pop(context);
        }

        nextPage();
      } else {
        List<dynamic> message = body['message'] as List<dynamic>;

        print('Error getting user with email: ${body['message']}');
        _changeLoadingState(false);
        if (context.mounted) {
          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            textContent: message.first,
            context: context,
          );

          Navigator.pop(context);
        }
      }
    } catch (e) {
      print('Error finding user with email: $e');
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

  Future<void> sendVeriCode({
    required Map<String, dynamic> data,
    required Function nextPage,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      showCustomLoader(context);

      Response response = await AuthRepo.sendVeriCode(body: data);

      int statusCode = response.statusCode;

      if (statusCode == 201) {
        print(jsonDecode(response.body.toString()));
        if (context.mounted) Navigator.pop(context);
        nextPage();
      }
    } catch (e) {
      print('Error sending verification code: $e');
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

  Future<void> verifyOtp({
    required Map<String, dynamic> data,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      showCustomLoader(context);

      print(data);

      Response response = await AuthRepo.verifyOtp(body: data);

      int statusCode = response.statusCode;
      dynamic body = jsonDecode(response.body);
      print(statusCode);
      List<dynamic> message = body['message'] as List<dynamic>;

      if (statusCode == 201) {
        if (context.mounted) {
          Navigator.pop(context);

          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            textContent: message.first,
            context: context,
            bkgColor: Colors.green,
          );

          Navigator.pushReplacementNamed(
            context,
            CreateNewPassword.routeName,
          );
        }
      } else {
        print('Error verifying otp: ${body['message']}');
        _changeLoadingState(false);
        if (context.mounted) {
          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            textContent: message.first,
            context: context,
          );

          Navigator.pop(context);
        }
      }
    } catch (e) {
      print('Error verifying otp: $e');
      if (context.mounted) {
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent:
              'An error occured while verifying otp, please try again.',
          context: context,
        );

        Navigator.pop(context);
      }
    }
  }

  Future<void> changePassword({
    required String password,
    required String confPassword,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      _changeLoadingState(true);
      showCustomLoader(context);

      Response response = await AuthRepo.forgotPassword(
        email: _forgottenUserDetails?['email'].toString() ?? '',
        password: password,
        confPassword: confPassword,
      );

      dynamic body = jsonDecode(response.body);
      int statusCode = response.statusCode;

      if (statusCode == 201) {
        if (context.mounted) Navigator.pop(context);
        Future.delayed(const Duration(seconds: 5), () {
          _changeLoggedInState(true);
        });

        if (context.mounted) {
          CustomMessageBottomSheet.showBottomSheet(
            context,
            'Successful!',
            'You have successfully reset your password, you will be redirected to the login page in a few seconds',
            Icons.check,
          );
        }
      } else {
        List<dynamic> message = body['message'] as List<dynamic>;

        print('Error changing password: ${body['message']}');
        _changeLoadingState(false);
        if (context.mounted) {
          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            textContent: message.first,
            context: context,
          );

          Navigator.pop(context);
        }
      }
    } catch (e) {
      print('Error changing password user in: $e');
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

  Future<void> _verifyEmail({
    required String email,
  }) async {
    try {
      Response response = await AuthRepo.verifyEmail(
        email: email,
      );

      if (response.statusCode != 200) {
        return;
      }
    } catch (e) {
      print('Error verifying user email: $e');
    }
  }
}

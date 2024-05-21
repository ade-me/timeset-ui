import 'package:http/http.dart';

import '../constants/api_urls.dart';
import '../services/api_client.dart';

class AuthRepo {
  static Future<Response> login({
    required String email,
    required String password,
  }) async {
    return ApiClient.postData(
      ApiUrls.login,
      data: {
        "email": email,
        "password": password,
      },
    );
  }

  static Future<Response> signUp({
    required String email,
    required String password,
  }) async {
    return ApiClient.postData(
      ApiUrls.signUp,
      data: {
        "email": email,
        "password": password,
      },
    );
  }

  static Future<Response> forgotPassword({
    required String email,
    required String password,
    required String confPassword,
  }) async {
    return ApiClient.postData(
      ApiUrls.forgotPassword,
      data: {
        "email": email,
        "password": password,
        "confirmPassword": confPassword,
      },
    );
  }

  static Future<Response> verifyOtp({
    required String email,
    required int code,
  }) async {
    return ApiClient.postData(
      ApiUrls.verifyOtpCode,
      data: {
        "email": email,
        "pin": code,
      },
    );
  }

  static Future<Response> sendVeriCode({
    required String email,
    required String phoneNumber,
  }) async {
    return ApiClient.postData(
      ApiUrls.login,
      data: {
        "email": email,
        "phone": phoneNumber,
      },
    );
  }
}

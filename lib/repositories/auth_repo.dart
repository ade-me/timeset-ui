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
      body: {
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
      body: {
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
      body: {
        "email": email,
        "password": password,
        "confirmPassword": confPassword,
      },
    );
  }

  static Future<Response> verifyOtp({
    required Map<String, dynamic> body,
  }) async {
    return ApiClient.postData(
      ApiUrls.verifyOtpCode,
      body: body,
    );
  }

  static Future<Response> sendVeriCode({
    required Map<String, dynamic> body,
  }) async {
    return ApiClient.postData(
      ApiUrls.sendVeriCode,
      body: body,
    );
  }

  static Future<Response> findUserWithEmail({
    required String email,
  }) async {
    return ApiClient.fetchData(
      'auth/$email',
    );
  }
}

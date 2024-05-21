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
      ApiUrls.login,
      data: {
        "email": email,
        "password": password,
      },
    );
  }
}

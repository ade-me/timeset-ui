import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../constants/api_urls.dart';
import '../main.dart';
import '../screens/auth/auth_root.dart';
import '../state_management/shared_pref.dart';
import 'custom_toast.dart';

class ApiClient {
  static late BuildContext _appContext;

  static void setContext(BuildContext context) {
    _appContext = context;
  }

  static Map<String, String> _buildHeaders() {
    var sharedPrefPvr = Provider.of<SharedPref>(_appContext, listen: false);

    sharedPrefPvr.getAuthToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Platform': 'mobile',
      'Authorization': 'Bearer ${sharedPrefPvr.authToken}',
    };

    return headers;
  }

  // get data
  static Future<Response> fetchData(String endpoint) async {
    Response response = await http
        .get(
          Uri.parse('${ApiUrls.baseUrl}$endpoint'),
          headers: _buildHeaders(),
        )
        .timeout(const Duration(seconds: 30))
        .then(
      (value) {
        tokenExpired(value);

        return value;
      },
    );

    tokenExpired(response);

    return response;
  }

  // post data
  static Future<Response> postData(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    Response response = await http
        .post(
          Uri.parse('${ApiUrls.baseUrl}$endpoint'),
          headers: _buildHeaders(),
          body: jsonEncode(data),
        )
        .timeout(const Duration(seconds: 30))
        .then(
      (value) {
        tokenExpired(value);

        return value;
      },
    );

    return response;
  }

  static void tokenExpired(Response response) async {
    if (response.statusCode == 409) {
      await CustomToast.showCustomToast("Session expired").then((value) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          AuthRoot.routeName,
          (route) => false,
        );

        return value;
      });
    }
  }
}

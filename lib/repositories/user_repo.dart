import 'package:http/http.dart';

import '../constants/api_urls.dart';
import '../services/api_client.dart';

class UserRepo {
  static Future<Response> updateUserProfile({
    required Map<String, dynamic> data,
  }) async {
    return await ApiClient.patchData(
      ApiUrls.updateUser,
      body: data,
    );
  }
}

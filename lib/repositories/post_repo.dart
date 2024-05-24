import 'package:http/http.dart';

import '../constants/api_urls.dart';
import '../services/api_client.dart';

class PostRepo {
  static Future<Response> createPost({
    required String title,
    required String description,
    required List<Map<String, dynamic>> content,
    required List<String> people,
    required List<String> product,
    required List<String> location,
    required bool allowComment,
  }) async {
    return ApiClient.postData(
      ApiUrls.post,
      body: {
        "title": title,
        "description": description,
        "content": content,
        "people": people,
        "product": product,
        "location": location,
        "allowComment": allowComment,
      },
    );
  }
}

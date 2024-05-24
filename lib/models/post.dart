import '../models/content.dart';

class Post {
  final String title;
  final String description;
  final List<Content> content;
  final bool allowComment;
  final List<String> people;
  final List<String> product;
  final List<String> location;

  Post({
    required this.title,
    required this.description,
    required this.content,
    required this.allowComment,
    required this.people,
    required this.product,
    required this.location,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    List<dynamic> contentJson = json['content'] ?? [];
    List<Content> contentList =
        contentJson.map((content) => Content.fromJson(content)).toList();

    return Post(
      title: json['title'],
      description: json['description'],
      content: contentList,
      allowComment: json['allowComment'],
      people: List<String>.from(json['people'] ?? []),
      product: List<String>.from(json['product'] ?? []),
      location: List<String>.from(json['location'] ?? []),
    );
  }
}

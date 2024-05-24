class Content {
  final String uri;
  final String type;
  final String effect;

  Content({
    required this.uri,
    required this.type,
    required this.effect,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      uri: json['uri'],
      type: json['type'],
      effect: json['effect'],
    );
  }
}

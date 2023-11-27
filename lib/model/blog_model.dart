class BlogPost {
  final String title;
  final String image;
  final String source;
  final String description;
  // Update to Future<String>
  final String url;

  BlogPost({
    required this.title,
    required this.image,
    required this.source,
    required this.description,
    required this.url,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      source: json['source']['name'] ?? 'Anonymous',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

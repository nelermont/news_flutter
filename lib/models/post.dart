class Post {
  String? id;
  String? title;
  String? description;
  String? imageUrl;
  String? publicationDate;

  Post(
      {required this.id,
      required this.title,
      this.description,
      required this.imageUrl,
      required this.publicationDate});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        imageUrl: json['imageUrl'] ?? '',
        publicationDate: json['publicationDate'] ?? '',
      );
}

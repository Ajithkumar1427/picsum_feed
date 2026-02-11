class PicsumModel {
  final String id;
  final String author;

  PicsumModel({
    required this.id,
    required this.author,
  });

  factory PicsumModel.fromJson(Map<String, dynamic> json) {
    return PicsumModel(
      id: json['id'],
      author: json['author'],
    );
  }
}

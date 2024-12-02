class BookEntity {
  final int id;
  final String title;
  final String author;
  final String publisher;
  final String overview;
  final String readTime;
  final String releaseDate;
  final String imageUrl;

  BookEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.publisher,
    required this.overview,
    required this.readTime,
    required this.releaseDate,
    required this.imageUrl,
  });

  factory BookEntity.fromJson(Map<String, dynamic> json) {
    return BookEntity(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        publisher: json['publisher'],
        overview: json['overview'],
        readTime: json['read_time'],
        releaseDate: json['release_date'],
        imageUrl: json['image_url']);
  }
}

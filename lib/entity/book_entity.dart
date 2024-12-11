class BookEntity {
  final int? id;
  final String? title;
  final String? author;
  final String? publisher;
  final String? overview;
  final String? readTime;
  final String? releaseDate;
  final String? imageUrl;

  const BookEntity({
    this.id,
    this.title,
    this.author,
    this.publisher,
    this.overview,
    this.readTime,
    this.releaseDate,
    this.imageUrl,
  });

  const BookEntity.empty()
      : id = null,
        title = null,
        author = null,
        publisher = null,
        overview = null,
        readTime = null,
        releaseDate = null,
        imageUrl = null;

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

  BookEntity copyWith({
    int? id,
    String? title,
    String? author,
    String? publisher,
    String? overview,
    String? readTime,
    String? releaseDate,
    String? imageUrl,
  }) {
    return BookEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      publisher: publisher ?? this.publisher,
      overview: overview ?? this.overview,
      readTime: readTime ?? this.readTime,
      releaseDate: releaseDate ?? this.releaseDate,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

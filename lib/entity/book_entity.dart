class BookEntity {
  final String imageUrl;
  final String title;
  final String author;
  final String publisher;
  final String copyNumber;
  final String fileSize;
  final String readers;
  final String reviews;
  final String readTime;

  BookEntity({
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.publisher,
    required this.copyNumber,
    required this.fileSize,
    required this.readers,
    required this.reviews,
    required this.readTime,
  });

  factory BookEntity.fromJson(Map<String, dynamic> json) {
    return BookEntity(
     
      imageUrl: json['imageUrl'],
      title: json['title'],
      author: json['author'],
      publisher: json['publisher'],
      copyNumber: json['copyNumber'],
      fileSize: json['fileSize'],
      readers: json['readers'],
      reviews: json['reviews'],
      readTime: json['readTime']
    );
  }
}
List<BookEntity> dummyBooks = [
  BookEntity(
    imageUrl: 'https://via.placeholder.com/150',
    title: 'Milk and honey',
    author: 'Rupi Kaur',
    publisher: 'Andrews McMeel Publishing',
    copyNumber: '10',
    fileSize: '3.7 MB',
    readers: '0',
    reviews: '9',
    readTime:'25',
    
  ),
  BookEntity(
    imageUrl: 'https://via.placeholder.com/150',
    title: 'Deer\'s',
    author: 'John Doe',
    publisher: 'Doe Publishing',
    copyNumber: '5',
    fileSize: '2.5 MB',
    readers: '10',
    reviews: '10',
    readTime:'25',
  ),
  BookEntity(
    imageUrl: 'https://via.placeholder.com/150',
    title: 'Tonya and her perfect tea',
    author: 'Alina Slyshik',
    publisher: 'Grasindo (Gramedia Widya Sarana Indonesia)',
    copyNumber: '10',
    fileSize: '3.7 MB',
    readers: '14',
    reviews: '25',
    readTime:'25',
  ),
  BookEntity(
    imageUrl: 'https://via.placeholder.com/150',
    title: 'Waves',
    author: 'Sarah Lee',
    publisher: 'Penguin Random House',
    copyNumber: '20',
    fileSize: '5.0 MB',
    readers: '30',
    reviews: '43',
    readTime:'25',
  ),
];

List<BookEntity> borrowedBooks = [];


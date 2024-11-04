import 'package:flutter/material.dart';
import 'package:myapp/entity/book_entity.dart';
import 'package:myapp/presentation/page/detail_book_page.dart';

class BookGridTile extends StatelessWidget {
  final BookEntity book;

  const BookGridTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBookPage(
              book: book,
            ),
          ),
        );
      },
      child: GridTile(
        footer: Container(
          color: Colors.blueGrey[100],
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${book.readers} Readers, ${book.reviews} Reviews'),
              const Divider(height: 10, color: Colors.black),
              Row(
                children: [
                  const Icon(Icons.watch_later_outlined),
                  const SizedBox(width: 5),
                  Text(
                      '${book.readTime} mins'), // Placeholder for the reading time
                ],
              ),
            ],
          ),
        ),
        child: Image.network(
          book.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

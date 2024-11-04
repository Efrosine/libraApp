import 'package:flutter/material.dart';
import 'package:myapp/entity/book_entity.dart';

class DetailBookPage extends StatelessWidget {
  final BookEntity book;

  const DetailBookPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  book.imageUrl,
                  fit: BoxFit.cover,
                  height: 300,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                     bool isAlreadyBorrowed = borrowedBooks.any((borrowedBook) => borrowedBook.title == book.title);

                    if (!isAlreadyBorrowed) {
                      borrowedBooks.add(book);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('You borrowed "${book.title}"')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('You already borrowed this book')),
                      );
                    }
                  },
                  icon: const Icon(Icons.add_box),
                  style: ElevatedButton.styleFrom(
                    
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  label: const Text('Borrow'),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Copy Number: ${book.copyNumber} Copy'),
                  Text('File Size: ${book.fileSize}'),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                book.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text('Author: ${book.author}'),
              Text('Publisher: ${book.publisher}'),
            ],
          ),
        ),
      ),
    );
  }
}

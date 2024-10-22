import 'package:flutter/material.dart';
import 'package:myapp/book_entity.dart';
import 'package:myapp/book_grid_tile.dart';

class BorrowedPage extends StatelessWidget {
  const BorrowedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Borrowed & Favourites Book')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: borrowedBooks.isEmpty
            ? const Center(child: Text('No borrowed books yet.'))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemCount: borrowedBooks.length,
                itemBuilder: (context, index) {
                  final book = borrowedBooks[index];
                  return BookGridTile(book: book);
                },
              ),
      ),
    );
  }
}

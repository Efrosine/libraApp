import 'package:flutter/material.dart';
import 'package:myapp/book_entity.dart';
import 'package:myapp/book_grid_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ePustaka')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          itemCount: dummyBooks.length,
          itemBuilder: (context, index) {
            final book = dummyBooks[index];
            return BookGridTile(
              book: book,
            );
          },
        ),
      ),
    );
  }
}

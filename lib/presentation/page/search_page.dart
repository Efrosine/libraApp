import 'package:flutter/material.dart';
import 'package:myapp/entity/book_entity.dart';
import 'package:myapp/presentation/component/book_grid_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<BookEntity> _filteredBooks = dummyBooks; // Awalnya tampilkan semua buku
  String _searchQuery = '';

  void _filterBooks(String query) {
    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        _filteredBooks = dummyBooks;
      } else {
        _filteredBooks = dummyBooks.where((book) {
          return book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                 book.author.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Books'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterBooks,
              decoration: const InputDecoration(
                labelText: 'Search by title or author',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: _filteredBooks.length,
              itemBuilder: (context, index) {
                final book = _filteredBooks[index];
                return BookGridTile(book: book);
              },
            ),
          ),
        ],
      ),
    );
  }
}

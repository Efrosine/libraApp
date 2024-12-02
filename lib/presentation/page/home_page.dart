import 'package:flutter/material.dart';
import 'package:myapp/entity/book_entity.dart';
import 'package:myapp/presentation/component/book_grid_tile.dart';
import 'package:myapp/service/api_service.dart';
// Pastikan path sesuai dengan struktur folder Anda

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();
  late Future<List<BookEntity>> books;

  @override
  void initState() {
    super.initState();
    books = apiService.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ePustaka')),
      body: FutureBuilder<List<BookEntity>>(
        future: books,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No books available"));
          } else {
            final books = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return BookGridTile(
                    book: book,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

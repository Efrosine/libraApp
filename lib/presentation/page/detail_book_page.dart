import 'package:flutter/material.dart';
import 'package:myapp/entity/book_entity.dart';
import 'package:myapp/service/api_service.dart';

class DetailBookPage extends StatefulWidget {
  final BookEntity book;

  const DetailBookPage({super.key, required this.book});

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  final apiservice = ApiService();
  bool isLoading = false;

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
                  widget.book.imageUrl,
                  fit: BoxFit.cover,
                  height: 300,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          String msg =
                              await apiservice.createLending(widget.book.id);
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(msg)));
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
              Text(widget.book.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
              Text('Author: ${widget.book.author}'),
              Text('Publisher: ${widget.book.publisher}'),
              Text('Release Date: ${widget.book.releaseDate}'),
              Text('Read Time: ${widget.book.readTime}'),
              Divider(),
              Text(
                'Overview',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(widget.book.overview),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

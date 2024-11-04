import 'package:dio/dio.dart';
import 'package:myapp/entity/book_entity.dart';


class BookService {
  final Dio _dio = Dio();
  final String _endpoint = 'https://pito.efrosine.my.id/api/books';

  Future<List<BookEntity>> fetchBooks() async {
    try {
      final response = await _dio.get(_endpoint);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => BookEntity.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      throw Exception('Error fetching books: $e');
    }
  }
}

import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:myapp/entity/lending_entity.dart';
import 'package:myapp/entity/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/entity/book_entity.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://book.efrosine.my.id/api',
    headers: {'Accept': 'application/json'},
  ));
  final SharedPreferencesAsync pref = SharedPreferencesAsync();

  Future<String?> getRole() async {
    var data = await pref.getString('role');
    log(data ?? 'nullll', name: 'inirole getrole');
    return data;
  }

  Future<List<BookEntity>> getBooks() async {
    try {
      final response = await _dio.get('/books');
      List<dynamic> data = response.data['data'] as List<dynamic>;
      return data.map((json) => BookEntity.fromJson(json)).toList();
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to load books : ${e.response?.data['message']}'));
    } catch (e) {
      return Future.error(Exception('Something whent wrong'));
    }
  }

  Future<UserEntity> getUser() async {
    try {
      int? id = await pref.getInt('id');
      String? token = await pref.getString('token');
      final response = await _dio.get(
        '/users/${id!}',
        options: Options(headers: {'authorization': 'Bearer ${token!}'}),
      );
      var data = response.data['data'];
      return UserEntity.fromJson(data);
    } on DioException catch (e) {
      String? token = await pref.getString('token');
      return Future.error(Exception(
          'Failed to load user :$token | ${e.response?.data['message']}'));
    } catch (e) {
      return Future.error(Exception('Something whent wrong ${e.toString()}'));
    }
  }

  Future<Map<String, dynamic>> getIdBookUser() async {
    try {
      String? token = await pref.getString('token');
      final response = await _dio.get(
        '/lendings/getBookUserId',
        options: Options(headers: {'authorization': 'Bearer ${token!}'}),
      );
      return response.data['data'];
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to load user  ${e.response?.data['message']}'));
    } catch (e) {
      return Future.error(Exception('Something whent wrong ${e.toString()}'));
    }
  }

  Future<String> requestLending(int bookId) async {
    try {
      int? id = await pref.getInt('id');
      String? token = await pref.getString('token');
      final response = await _dio.post('/users/requestLend',
          options: Options(headers: {
            'Accept': 'application/json',
            'authorization': 'Bearer ${token!}',
          }),
          data: {
            "user_id": id!,
            "book_id": bookId,
            "status": "pending",
            "lent_at": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          });
      return response.data['message'] ?? 'message null';
    } on DioException catch (e) {
      return Future.error(Exception(
          'Failed to request lending : ${e.response?.data['message']}'));
    } catch (e) {
      return Future.error(Exception('Something whent wrong :${e.toString()}'));
    }
  }

  Future<String> createLending(LendingEntity lending) async {
    try {
      String? token = await pref.getString('token');
      var data = lending.toJson();
      print('ini datanya $data');
      final response = await _dio.post('/lendings',
          options: Options(headers: {
            'Accept': 'application/json',
            'authorization': 'Bearer ${token!}',
          }),
          data: lending.toJson());
      return response.data['message'] ?? 'message null';
    } on DioException catch (e) {
      return Future.error(Exception(
          'Failed to create lending : ${e.response?.data['message']}'));
    } catch (e) {
      return Future.error(Exception('Something whent wrong :${e.toString()}'));
    }
  }

  Future<String> updateLending(LendingEntity lending) async {
    try {
      String? token = await pref.getString('token');
      final response = await _dio.put('/lendings/${lending.id}',
          options: Options(headers: {
            'Accept': 'application/json',
            'authorization': 'Bearer ${token!}',
          }),
          data: lending.toJson());
      return response.data['message'] ?? 'message null';
    } on DioException catch (e) {
      return Future.error(Exception(
          'Failed to create lending : ${e.response?.data['message']}'));
    } catch (e) {
      return Future.error(Exception('Something whent wrong :${e.toString()}'));
    }
  }

  Future<String> deleteLending(int userId) async {
    try {
      String? token = await pref.getString('token');
      final response = await _dio.delete(
        '/lendings/$userId',
        options: Options(headers: {
          'Accept': 'application/json',
          'authorization': 'Bearer ${token!}',
        }),
      );
      return response.data['message'] ?? 'message null';
    } on DioException catch (e) {
      return Future.error(Exception(
          'Failed to create lending : ${e.response?.data['message']}'));
    } catch (e) {
      return Future.error(Exception('Something whent wrong :${e.toString()}'));
    }
  }

  Future<List<LendingEntity>> getUserLending() async {
    try {
      int? id = await pref.getInt('id');
      String? token = await pref.getString('token');
      final response = await _dio.get(
        '/users/$id/lendings',
        options: Options(headers: {
          'Accept': 'application/json',
          'authorization': 'Bearer ${token!}',
        }),
      );
      List<dynamic> data = response.data['data'] as List<dynamic>;
      return data.map((json) => LendingEntity.fromJson(json)).toList();
    } on DioException catch (e) {
      return Future.error(
          Exception('Failed to load lending : ${e.response?.data['message']}'));
    } catch (e) {
      return Future.error(Exception('Something whent wrong: ${e.toString()}'));
    }
  }

  Future<String> login(String email, String pw) async {
    if (email.isEmpty && pw.isEmpty) {
      return Future.error(Exception('Email and Password cannot be empty'));
    }
    try {
      final response = await _dio.post(
        '/login',
        data: {"email": email, "password": pw},
      );
      String token = response.data['data']['token'];
      int id = response.data['data']['id'];
      String role = response.data['data']['role'];
      await pref.setString('token', token);
      await pref.setInt('id', id);
      await pref.setString('role', role);
      log(role, name: 'inirole setelah login');
      return response.data['message'] ?? 'message null';
    } on DioException catch (e) {
      return Future.error(
          Exception(e.response?.data['message'] ?? 'message error null'));
    } catch (e) {
      return Future.error(Exception('Something whent wrongn ${e.toString()}'));
    }
  }

  Future<String> register(
      String name, String email, String pw, String role) async {
    if (name.isEmpty && email.isEmpty && pw.isEmpty && role.isEmpty) {
      return Future.error(Exception('All fields cannot be empty'));
    }
    try {
      final response = await _dio.post(
        '/register',
        data: {"name": name, "email": email, "password": pw, "role": role},
      );
      return response.data['message'] ?? 'message null';
    } on DioException catch (e) {
      return Future.error(
          Exception(e.response?.data['message'] ?? 'message error null'));
    } catch (e) {
      return Future.error(Exception('Something whent wrong'));
    }
  }
}

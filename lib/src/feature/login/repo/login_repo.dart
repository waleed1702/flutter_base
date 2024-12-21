import 'dart:convert';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/feature/product/res/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod_base/src/models/user.dart';
import 'package:http/http.dart';

final productRepoProvider = Provider((ref) {
  final api = ref.watch(networkRepoProvider);
  return AuthRepo(api: api);
});

class AuthRepo {
  final NetworkRepo _api;
  final String _baseUrl = 'https://dummyjson.com';
  AuthRepo({required NetworkRepo api}) : _api = api;

  // Future<User?> login({
  //   required String username,
  //   required String password,
  // }) async {
  //   try {
  //     // Make the HTTP POST request
  //     final response = await http.post(
  //       Uri.parse('$_baseUrl/auth/login'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         'username': username,
  //         'password': password,
  //         'expiresInMins': 30, // Optional, defaults to 60
  //       }),
  //     );

  //     // Handle response
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);

  //       // Parse the user data from the response
  //       final user = User(
  //         id: data['id'].toString(),
  //         name: data['firstName'] + ' ' + data['lastName'],
  //         email: data['email'] ?? 'unknown@example.com',
  //       );

  //       return user;
  //     } else {
  //       // Handle non-200 responses
  //       print('Error: ${response.body}');
  //       return null;
  //     }
  //   } catch (_) {
  //     return null;
  //   }
  // }

  Future<User?> login({
    required String username,
    required String password,
  }) async {
    final result = await _api.postRequest(
      url: EndPoints.getUserLogin,
      body: {
        'username': username,
        'password': password,
        'expiresInMins': 8,
      },
      requireAuth: false,
    );

    return result.fold(
      (Failure failure) {
        return null;
      },
      (Response response) {
        try {
          final data = jsonDecode(response.body);
          final user = User(
            id: data['id'].toString(),
            name: data['firstName'] + ' ' + data['lastName'],
            email: data['email'] ?? 'unknown@example.com',
          );
          return user;
          //   log(productJson.toString(), name: _name);
          //   final List<Product> products = [];
          //   for (dynamic product in productJson) {
          //     log(product.toString(), name: _name);
          //     products.add(Product.fromMap(product));
          //   }
          //   return Right(products);
          // } catch (e, stktrc) {
          //   log(FailureMessage.jsonParsingFailed, name: _name);
          //   return Left(Failure(
          //     message: FailureMessage.jsonParsingFailed,
          //     stackTrace: stktrc,
          //   ));
        } catch (_) {
          return null;
        }
      },
    );
  }
}

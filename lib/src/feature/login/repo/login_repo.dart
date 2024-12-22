import 'package:flutter_riverpod_base/src/feature/product/res/endpoints.dart';
import 'package:flutter_riverpod_base/src/models/user.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'dart:developer';
import 'dart:convert';

final loginReoProvider = Provider((ref) {
  final api = ref.watch(networkRepoProvider);
  return AuthRepo(api: api);
});

class AuthRepo {
  final _name = "LOGIN_API";
  final NetworkRepo _api;
  AuthRepo({required NetworkRepo api}) : _api = api;

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
        log(failure.message, name: _name);
        return null;
      },
      (Response response) {
        try {
          final data = jsonDecode(response.body);
          final user = User(
            id: data['id'].toString(),
            name: data['firstName'] + ' ' + data['lastName'],
            email: data['email'] ?? 'unknown@example.com',
            pass: data['password'] ?? password,
          );
          return user;
        } catch (_) {
          return null;
        }
      },
    );
  }
}

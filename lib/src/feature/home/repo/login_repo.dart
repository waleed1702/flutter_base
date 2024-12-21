import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_base/src/models/user.dart';

final authRepoProvider = Provider<AuthRepo>((ref) {
  return AuthRepo();
});

class AuthRepo {
  Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      if (email == "test" && password == "password") {
        final user = User(name: "John Doe", email: email, id: '');
        return (user);
      } else {
        return null;
      }
    } catch (e) {
      return null;
      //Left(Failure("Something went wrong. Please try again."));
    }
  }
}

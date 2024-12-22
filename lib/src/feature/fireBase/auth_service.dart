import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

import 'package:flutter_riverpod_base/src/models/user.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserAcc?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserAcc? user;
      if (cred.user != null) {
        user = UserAcc(
          id: cred.user!.uid.toString(),
          name: email,
          email: email,
          pass: password,
        );
      }
      return user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<UserAcc?> loginUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      UserAcc? user;
      if (cred.user != null) {
        user = UserAcc(
          id: cred.user!.uid.toString(),
          name: cred.user!.displayName.toString(),
          email: email,
          pass: password,
        );
      }
      return user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong");
    }
  }
}

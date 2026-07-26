import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  String _emailFromNumber(String number) {
    final cleanNumber = number.trim().replaceAll(RegExp(r'[^0-9]'), '');
    return "$cleanNumber@client.pizza-app.local";
  }

  Future<UserCredential> signIn({
    required String number,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: _emailFromNumber(number),
      password: password,
    );
  }

  Future<void> siginOut() async {
    await firebaseAuth.signOut();
  }

  Future<UserCredential> creatAccount({
    required String number,
    required String password,
  }) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: _emailFromNumber(number),
      password: password,
    );
  }
    Future<void> changePassword({
    required String number,
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = firebaseAuth.currentUser;
    if (user == null) throw Exception("No user is logged in");

    final credential = EmailAuthProvider.credential(
      email: _emailFromNumber(number),
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  /// login:
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// logout:
  Future<void> siginOut() async {
    await firebaseAuth.signOut();
  }
   Future<void> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = firebaseAuth.currentUser;
    if (user == null) throw Exception("No user is logged in");

    final credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }

  // /// creatnewaccount:
  // Future<UserCredential> creatAccount({
  //   required String email,
  //   required String password,
  // }) async {
  //   return await firebaseAuth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }

  // /// updateUsername:
  // Future<void> updateUsername({required String username}) async {
  //   await currentUser!.updateDisplayName(username);
  // }

  // /// reset password:
  // Future<void> resetPassword({required String email}) async {
  //   await firebaseAuth.sendPasswordResetEmail(email: email);
  // }

  // /// delete account:
  // Future<void> deleteAccount({
  //   required String email,
  //   required String password,
  // }) async {
  //   AuthCredential credential = EmailAuthProvider.credential(
  //     email: email,
  //     password: password,
  //   );
  //   await currentUser!.reauthenticateWithCredential(credential);
  //   await currentUser!.delete();
  //   await firebaseAuth.signOut();
  // }

  //   /// reset Password from currentpassword:
  // Future<void> resetPasswordfromcurrentpassword({
  //   required String currentPassword,
  //   required String email,
  //   required String newpassword,
  // }) async {
  //   AuthCredential credential = EmailAuthProvider.credential(
  //     email: email,
  //     password: currentPassword,
  //   );
  //   await currentUser!.reauthenticateWithCredential(credential);
  //   await currentUser!.updatePassword(newpassword);
  // }
}

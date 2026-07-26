import 'package:app_owner/firebase/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final userCredential = await _authService.signIn(
        email: email,
        password: password,
      );
      return userCredential.user != null;
    } catch (e) {
      debugPrint("login error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.siginOut();
      return true;
    } catch (e) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.changePassword(
        email: email,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return null;
    } on Exception catch (e) {
      final message = e.toString();
      if (message.contains('wrong-password') ||
          message.contains('invalid-credential')) {
        return "The current password is incorrect.";
      }
      if (message.contains('weak-password')) {
        return "The new password is very weak.";
      }
      return "Password change failed, please try again.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

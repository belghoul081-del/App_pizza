import 'package:app_pizza_client/firebase/auth/auth_service.dart';
import 'package:app_pizza_client/firebase/firestore/service/chats_service.dart';
import 'package:app_pizza_client/firebase/firestore/service/clients_service.dart';
import 'package:app_pizza_client/models/client/client_Model.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final ClientsFirestoreService _clientsService = ClientsFirestoreService();
  final ChatsFirestoreService _chatsService = ChatsFirestoreService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Client_Model? _currentClient;
  Client_Model? get currentClient => _currentClient;
  String? get currentUid => _currentClient?.uID;

  Future<bool> signIn(String number, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final userCredential = await _authService.signIn(
        number: number,
        password: password,
      );
      if (userCredential.user != null) {
        final uid = userCredential.user!.uid;
        ///  جلب بيانات المستخدم وتخزينها في الذاكرة 
        _currentClient = await _clientsService.getClientProfile(uid);
        notifyListeners();
        return true;
      }
      return false;
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
      _currentClient = null;
      return true;
    } catch (e) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// إنشاء حساب زبون جديد بالاسم/الرقم/كلمة السر 
  Future<bool> newaccount({
    required String number,
    required String password,
    required String name,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final credential = await _authService.creatAccount(
        number: number,
        password: password,
      );
      final uid = credential.user!.uid;
      final newClient = Client_Model(name: name, number: number);

      await _clientsService.createClientProfile(uid, newClient);
      // await NotificationService().updateTokenIfNeeded();
 await _chatsService.createChatThread(
        clientId: uid,
        clientName: newClient.name,
        clientImage: newClient.image,
      );
      return true;
    } catch (e) {
      debugPrint("signup error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
   Future<String?> changePassword({
    required String number,
    required String currentPassword,
    required String newPassword,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.changePassword(
        number: number,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return null;
    } on Exception catch (e) {
      final message = e.toString();
      if (message.contains('wrong-password') || message.contains('invalid-credential')) {
       return "The current password is incorrect";
      }
      if (message.contains('weak-password')) {
        return "The new password is too weak";
      }
      return "Failed to change password, please try again";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}

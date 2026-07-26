import 'dart:io';
import 'package:app_pizza_client/firebase/firestore/service/chats_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_pizza_client/models/client/client_Model.dart';
import 'package:app_pizza_client/firebase/firestore/service/clients_service.dart';
import 'package:app_pizza_client/firebase/storage/storage_service.dart';
import 'package:app_pizza_client/service/service_PhotoProduct.dart';
import 'package:image_picker/image_picker.dart';

/// يحمّل بيانات الزبون الحالي (اسم/رقم/صورة) مرة واحدة بعد تسجيل الدخول،
class ClientProvider extends ChangeNotifier {
  final ClientsFirestoreService _service = ClientsFirestoreService();
  final StorageService _storageService = StorageService();
  final ImagePickerService _imagePickerService = ImagePickerService();

  Client_Model _client = Client_Model();
  Client_Model get client => _client;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isUpdatingImage = false;
  bool get isUpdatingImage => _isUpdatingImage;

  //  متغيّر مؤشر يحدد هل تم جلب البيانات الفعليّة من الفايربيس أم لا
  bool _isProfileLoaded = false;
  bool get isProfileLoaded => _isProfileLoaded;

  String? get uid => FirebaseAuth.instance.currentUser?.uid;

  Future<void> loadClient({bool forceRefresh = false}) async {
    final currentUid = uid;
    if (currentUid == null) return;

    if (_isProfileLoaded && !forceRefresh) return;
    _isLoading = true;
    notifyListeners();

    try {
      final profile = await _service.getClientProfile(currentUid);
      if (profile != null) {
        _client = profile;
        _isProfileLoaded = true;
      }
    } catch (e) {
      debugPrint("error loading client profile: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateProfileImage(ImageSource source) async {
    final currentUid = uid;
    if (currentUid == null) return false;

    final File? croppedImage = await _imagePickerService.pickImage(source);
    if (croppedImage == null) return false;

    _isUpdatingImage = true;
    notifyListeners();

    try {
      final imageUrl = await _storageService.uploadClientImage(
        uid: currentUid,
        imageFile: croppedImage,
      );
      await _service.updateClientImage(currentUid, imageUrl);
      await ChatsFirestoreService().updateChatClientImage(currentUid, imageUrl);
      _client.image = imageUrl;
      return true;
    } catch (e) {
      debugPrint("error updating profile image: $e");
      return false;
    } finally {
      _isUpdatingImage = false;
      notifyListeners();
    }
  }

  Future<bool> updateName(String newName) async {
    final currentUid = uid;
    if (currentUid == null || newName.trim().isEmpty) return false;

    try {
      await _service.updateClientName(currentUid, newName.trim());
      _client.name = newName.trim();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("error updating name: $e");
      return false;
    }
  }

  void clearClientData() {
    _client = Client_Model();
    _isProfileLoaded = false;
    notifyListeners();
  }
}

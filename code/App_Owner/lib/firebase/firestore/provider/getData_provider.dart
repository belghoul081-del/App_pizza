import 'package:app_owner/firebase/firestore/service/fireStore_service.dart';
import 'package:app_owner/models/admin/admin_model.dart';
import 'package:flutter/material.dart';

/// get data
class GetdataProvider extends ChangeNotifier {
  final FirestoreService _FirestoreService = FirestoreService();

  List<Admin_Model> _admin = [];
  List<Admin_Model> get admin => _admin;

  Admin_Model _adminPP = Admin_Model();
  Admin_Model get adminPP => _adminPP;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasLoaded = false;

  bool _isProfileLoaded = false;
  bool get isProfileLoaded => _isProfileLoaded;

  Future<void> LoadData_Admin({bool forceReload = false}) async {
    if (_hasLoaded && !forceReload) return;

    _isLoading = true;
    notifyListeners();

    try {
      final rawData = await _FirestoreService.GetAdminInf();

      _admin = rawData.map((data) => Admin_Model.fromMap(data)).toList();
      _hasLoaded = true;
    } catch (e) {
      debugPrint("error loading admin: ${e}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearAdminData() {
    _adminPP = Admin_Model();
    _isProfileLoaded = false;
    notifyListeners();
  }

  void updateLocalStoreStatus(bool isOpenStatus) {
    if (_admin.isNotEmpty) {
      _admin[0].isOpen = isOpenStatus;
      notifyListeners();
    }
  }

  void updateLocalNumbers({required String number, required String number2}) {
    if (_admin.isNotEmpty) {
      _admin[0].number = number;
      _admin[0].number2 = number2;
      notifyListeners();
    }
  }
}

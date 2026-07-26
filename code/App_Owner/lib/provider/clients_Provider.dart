import 'package:app_owner/firebase/firestore/service/clients_service.dart';
import 'package:app_owner/models/client/client_Model.dart';
import 'package:flutter/material.dart';

/// ✅ جديد: يجلب كل بيانات المستخدمين (الزبائن) دفعة واحدة ويحتفظ بها في
/// الذاكرة، بنفس فكرة GetdataProvider الخاص ببيانات المالك.
class ClientsProvider extends ChangeNotifier {
  final ClientsFirestoreService _clientsService = ClientsFirestoreService();

  List<Client_Model> _clients = [];
  List<Client_Model> get clients => _clients;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasLoaded = false;

  Future<void> loadAllClients({bool forceReload = false}) async {
    if (_hasLoaded && !forceReload) return;

    _isLoading = true;
    notifyListeners();

    try {
      final rawData = await _clientsService.getAllClients();
      _clients = rawData.map((data) => Client_Model.fromMap(data)).toList();
      _hasLoaded = true;
    } catch (e) {
      debugPrint("error loading clients: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

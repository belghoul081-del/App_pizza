import 'package:app_pizza_client/models/model_sepliment/sepliment_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SupplementsFirestoreService {
  static const String collection = 'supplements';
  static const String docId = 'global';

  static Future<List<Sepliment_model>> loadGeneralSupplements() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .get();
      if (doc.exists && doc.data() != null) {
        final List<dynamic> list = doc.data()!['supplements'] ?? [];
        return list.map((e) => Sepliment_model.fromMap(e)).toList();
      }
    } catch (e) {
      debugPrint('Error loading supplements: $e');
    }
    return [];
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_pizza_client/models/model_products/products_Model.dart';

/// نسخة القراءة فقط لتطبيق العميل: يعرض المنتجات التي أضافها المالك،
class ProductsFirestoreService {
  final CollectionReference _productsRef = FirebaseFirestore.instance
      .collection('products');

  Stream<List<Products_model>> streamProducts() {
    return _productsRef.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => Products_model.fromMap(
              doc.id,
              doc.data() as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}

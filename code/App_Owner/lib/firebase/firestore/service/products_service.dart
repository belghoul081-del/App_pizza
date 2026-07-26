import 'dart:io';
import 'package:app_owner/models/model_sepliment/sepliment_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_owner/models/model_products/products_Model.dart';
import 'package:app_owner/firebase/storage/storage_service.dart';

class ProductsFirestoreService {
  final CollectionReference _productsRef = FirebaseFirestore.instance
      .collection('products');
  final StorageService _storageService = StorageService();

  /// ستريم لحظي: أي تعديل/إضافة/حذف على مجموعة "products" في Firestore
  /// (من هذا التطبيق أو من Firebase Console) ينعكس فورًا في واجهة المالك.
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

  /// إضافة منتج جديد: يرفع الصورة أولًا إلى Storage، ثم يكتب مستند المنتج
  /// في Firestore برابط الصورة الناتج.
  Future<void> addProduct({
    required Products_model product,
    required File imageFile,
  }) async {
    final imageUrl = await _storageService.uploadProductImage(
      productId: product.id,
      imageFile: imageFile,
    );

    final data = product.toMap();
    data['imagePath'] = imageUrl;

    await _productsRef.doc(product.id).set(data);
  }

  /// تحديث منتج موجود. إن تم اختيار صورة جديدة (newImageFile) يتم رفعها
  /// واستبدال الصورة القديمة، وإلا يبقى رابط الصورة الحالي كما هو.
  Future<void> updateProduct(
    Products_model product, {
    File? newImageFile,
  }) async {
    String imagePath = product.imagePath;
    if (newImageFile != null) {
      imagePath = await _storageService.uploadProductImage(
        productId: product.id,
        imageFile: newImageFile,
      );
    }

    final data = product.toMap();
    data['imagePath'] = imagePath;
    data.remove('supplements');
    await _productsRef.doc(product.id).update(data);
  }

  Future<void> updateSupplements(
    String productId,
    List<Sepliment_model> supplements,
  ) async {
    await _productsRef.doc(productId).update({
      'supplements': supplements.map((s) => s.toMap()).toList(),
    });
  }

  Future<void> deleteProduct(String id) async {
    await _productsRef.doc(id).delete();
    await _storageService.deleteProductImage(id);
  }
}

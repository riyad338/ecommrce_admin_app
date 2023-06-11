import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_own/models/product_model.dart';
import 'package:ecommerce_own/models/purchase_model.dart';

class FirestoreHelper {
  static const String _collectionAdmin = 'Admins';
  static const String _collectionProduct = 'Products';
  static const String _collectionDistributorProduct = 'Distributor Products';
  static const String _collectionPurchases = 'Purchases';
  static const String _collectionDistributorPurchases = 'Distributor Purchases';
  static const String _collectionCategory = 'Categories';
  static const String _collectionOrders = 'Orders';
  static const _collectionDistributorOrder = 'Distributor Orders';
  static const String _collectionOrderDetails = 'OrderDetails';
  static const String _collectionOrderUtils = 'OrderUtils';
  static const String _documentConstants = 'Constants';

  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCategories() =>
      _db.collection(_collectionCategory).snapshots();
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(_collectionProduct).snapshots();
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getAllDistributorProducts() =>
          _db.collection(_collectionDistributorProduct).snapshots();
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllPurchaseByProductId(
          String id) =>
      _db
          .collection(_collectionPurchases)
          .where('productId', isEqualTo: id)
          .snapshots();
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getProductByProductId(
          String id) =>
      _db.collection(_collectionProduct).doc(id).snapshots();
  static Stream<DocumentSnapshot<Map<String, dynamic>>>
      getDistributorProductByProductId(String id) =>
          _db.collection(_collectionDistributorProduct).doc(id).snapshots();

  static Future<void> addNewProduct(
      ProductModel productModel, PurchaseModel purchaseModel) {
    final wb = _db.batch();
    final productDocRef = _db.collection(_collectionProduct).doc();
    final purchaseDocRef = _db.collection(_collectionPurchases).doc();
    productModel.id = productDocRef.id;
    purchaseModel.purchaseId = purchaseDocRef.id;
    purchaseModel.productId = productDocRef.id;
    wb.set(productDocRef, productModel.toMap());
    wb.set(purchaseDocRef, purchaseModel.toMap());
    return wb.commit();
  }

  static Future<void> addDistributorNewProduct(
      ProductModel productModel, PurchaseModel purchaseModel) {
    final wb = _db.batch();
    final productDocRef = _db.collection(_collectionDistributorProduct).doc();
    final purchaseDocRef =
        _db.collection(_collectionDistributorPurchases).doc();
    productModel.id = productDocRef.id;
    purchaseModel.purchaseId = purchaseDocRef.id;
    purchaseModel.productId = productDocRef.id;
    wb.set(productDocRef, productModel.toMap());
    wb.set(purchaseDocRef, purchaseModel.toMap());
    return wb.commit();
  }

  static Future<bool> checkAdmin(String email) async {
    final snapshot = await _db
        .collection(_collectionAdmin)
        .where('email', isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  static Future<void> updateProductIsAvailableorNot(
      String productId, bool available) {
    return _db
        .collection(_collectionProduct)
        .doc(productId)
        .update({'isAvailable': available});
  }

  static Future<void> updateDistributorProductIsAvailableorNot(
      String productId, bool available) {
    return _db
        .collection(_collectionDistributorProduct)
        .doc(productId)
        .update({'isAvailable': available});
  }

  static Future<void> updateProduct(String productId, String productName,
      String description, String offer, num price) {
    return _db.collection(_collectionProduct).doc(productId).update({
      'name': productName,
      'price': price,
      'description': description,
      'offer': offer
    });
  }

  static Future<void> updateDistributorProduct(String productId,
      String productName, String description, String offer, num price) {
    return _db.collection(_collectionDistributorProduct).doc(productId).update({
      'name': productName,
      'price': price,
      'description': description,
      'offer': offer
    });
  }

  static Future<void> addNewCategorie(String categorie, String doc) {
    return _db
        .collection(_collectionCategory)
        .doc(doc)
        .set({'name': categorie});
  }

  static Future<void> deleteCategorie(String doc) {
    return _db.collection(_collectionCategory).doc(doc).delete();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllOrderPending() =>
      _db
          .collection(_collectionOrders)
          .where('orderStatus', isEqualTo: "Pending")
          .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>>
      fetchAllOrderPendingDetails(String orderId) => _db
          .collection(_collectionOrders)
          .doc(orderId)
          .collection(_collectionOrderDetails)
          .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllOrders() =>
      _db.collection(_collectionOrders).snapshots();
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      fetchAllDistributorOrders() =>
          _db.collection(_collectionDistributorOrder).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllOrderDetails(
          String orderId) =>
      _db
          .collection(_collectionOrders)
          .doc(orderId)
          .collection(_collectionOrderDetails)
          .snapshots();
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      fetchAllDistributorOrderDetails(String orderId) => _db
          .collection(_collectionDistributorOrder)
          .doc(orderId)
          .collection(_collectionOrderDetails)
          .snapshots();

  static Future<void> updateOrderStatus(String orderId, String status) {
    return _db
        .collection(_collectionOrders)
        .doc(orderId)
        .update({'orderStatus': status});
  }

  static Future<void> updateDistributorOrderStatus(
      String orderId, String status) {
    return _db
        .collection(_collectionDistributorOrder)
        .doc(orderId)
        .update({'orderStatus': status});
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> fetchOrderConstants() =>
      _db.collection(_collectionOrderUtils).doc(_documentConstants).get();

  static Future<void> updateOrderConstants(
      num deliveryCharge, num vat, num discount) {
    return _db
        .collection(_collectionOrderUtils)
        .doc(_documentConstants)
        .update({
      'deliveryCharge': deliveryCharge,
      'vat': vat,
      'discount': discount,
    });
  }
}

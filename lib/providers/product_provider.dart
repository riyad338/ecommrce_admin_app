import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_own/auth/firebase_auth_service.dart';
import 'package:ecommerce_own/db/firestore_helper.dart';
import 'package:ecommerce_own/models/purchase_model.dart';
import 'package:flutter/foundation.dart';

import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<String> categoryList = [];
  List<ProductModel> productList = [];
  List<ProductModel> distributorProductList = [];
  List<PurchaseModel> purchaseList = [];
  List<PurchaseModel> distributorPurchaseList = [];

  init() {
    _getAllCategories();
    _getAllProducts();
    _getAllDistributorProducts();
  }

  void _getAllProducts() {
    FirestoreHelper.getAllProducts().listen((snapshot) {
      productList = List.generate(snapshot.docs.length,
          (index) => ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  void _getAllDistributorProducts() {
    FirestoreHelper.getAllDistributorProducts().listen((snapshot) {
      distributorProductList = List.generate(snapshot.docs.length,
          (index) => ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  void getPurchasesByProductId(String id) {
    FirestoreHelper.getAllPurchaseByProductId(id).listen((snapshot) {
      purchaseList = List.generate(snapshot.docs.length,
          (index) => PurchaseModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProductByProductId(
          String id) =>
      FirestoreHelper.getProductByProductId(id);
  Stream<DocumentSnapshot<Map<String, dynamic>>>
      getDistributorProductByProductId(String id) =>
          FirestoreHelper.getDistributorProductByProductId(id);

  void _getAllCategories() {
    FirestoreHelper.getCategories().listen((snapshot) {
      categoryList = List.generate(
          snapshot.docs.length, (index) => snapshot.docs[index].data()['name']);
      notifyListeners();
    });
  }

  Future<void> insertNewProduct(
      ProductModel productModel, PurchaseModel purchaseModel) {
    return FirestoreHelper.addNewProduct(productModel, purchaseModel);
  }

  Future<void> insertDistributorNewProduct(
      ProductModel productModel, PurchaseModel purchaseModel) {
    return FirestoreHelper.addDistributorNewProduct(
        productModel, purchaseModel);
  }

  Future<bool> checkAdmin(String email) {
    return FirestoreHelper.checkAdmin(email);
  }

  Future<void> updateProductIsAvailableorNot(
          String productId, bool available) =>
      FirestoreHelper.updateProductIsAvailableorNot(productId, available);
  Future<void> updateDistributorProductIsAvailableorNot(
          String productId, bool available) =>
      FirestoreHelper.updateDistributorProductIsAvailableorNot(
          productId, available);
  Future<void> updateProduct(String productId, String productName,
          String description, String offer, num price) =>
      FirestoreHelper.updateProduct(
          productId, productName, description, offer, price);
  Future<void> updateDistributorProduct(String productId, String productName,
          String description, String offer, num price) =>
      FirestoreHelper.updateDistributorProduct(
          productId, productName, description, offer, price);
  Future<void> addNewCategorie(String address, String doc) =>
      FirestoreHelper.addNewCategorie(address, doc);
  Future<void> deleteCategorie(String doc) =>
      FirestoreHelper.deleteCategorie(doc);
}

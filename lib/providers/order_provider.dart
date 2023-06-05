import 'package:ecommerce_own/db/firestore_helper.dart';
import 'package:ecommerce_own/models/cart_model.dart';
import 'package:ecommerce_own/models/order_constants_model.dart';
import 'package:ecommerce_own/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();
  List<OrderModel> pendingOrderList = [];
  List<CartModel> orderPendingDetailsList = [];
  List<OrderModel> orderList = [];
  List<OrderModel> distributorOrderList = [];
  List<CartModel> orderDetailsList = [];
  List<CartModel> distributorOrderDetailsList = [];

  init() {
    getAllPendingOrders();
    getAllOrders();
    // getOrderConstants();
  }

  void getAllPendingOrders() {
    FirestoreHelper.fetchAllOrderPending().listen((snapshot) {
      pendingOrderList = List.generate(snapshot.docs.length,
          (index) => OrderModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  void getOrderPendingDetails(String orderId) async {
    FirestoreHelper.fetchAllOrderPendingDetails(orderId).listen((snapshot) {
      orderPendingDetailsList = List.generate(snapshot.docs.length,
          (index) => CartModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  void getAllOrders() {
    FirestoreHelper.fetchAllOrders().listen((snapshot) {
      orderList = List.generate(snapshot.docs.length,
          (index) => OrderModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  void getAllDistributorOrders() {
    FirestoreHelper.fetchAllDistributorOrders().listen((snapshot) {
      distributorOrderList = List.generate(snapshot.docs.length,
          (index) => OrderModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  void getOrderDetails(String orderId) async {
    FirestoreHelper.fetchAllOrderDetails(orderId).listen((snapshot) {
      orderDetailsList = List.generate(snapshot.docs.length,
          (index) => CartModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  void getDistributorOrderDetails(String orderId) async {
    FirestoreHelper.fetchAllDistributorOrderDetails(orderId).listen((snapshot) {
      distributorOrderDetailsList = List.generate(snapshot.docs.length,
          (index) => CartModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  Future<void> updateOrderStatus(String orderId, String status) =>
      FirestoreHelper.updateOrderStatus(orderId, status);
  Future<void> updateDistributorOrderStatus(String orderId, String status) =>
      FirestoreHelper.updateDistributorOrderStatus(orderId, status);

  // void getOrderConstants() async {
  //   FirestoreHelper.fetchOrderConstants().listen((snapshot) {
  //     if (snapshot.exists) {
  //       orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
  //     }
  //   });
  // }

  Future<OrderConstantsModel?> getOrderConstants() async {
    final snapshot = await FirestoreHelper.fetchOrderConstants();
    if (!snapshot.exists) {
      return null;
    }
    return OrderConstantsModel.fromMap(snapshot.data()!);
  }

  Future<void> updateOrderConstants(
          num deliveryCharge, num vat, num discount) =>
      FirestoreHelper.updateOrderConstants(deliveryCharge, vat, discount);
}

import 'package:ecommerce_own/pages/pending_order_details_page.dart';
import 'package:ecommerce_own/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingOrderPage extends StatefulWidget {
  static const String routeName = '/pending_order';

  @override
  State<PendingOrderPage> createState() => _PendingOrderPageState();
}

class _PendingOrderPageState extends State<PendingOrderPage> {
  late OrderProvider _orderProvider;

  @override
  void didChangeDependencies() {
    _orderProvider = Provider.of<OrderProvider>(context);
    _orderProvider.getAllPendingOrders();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text("All Pending Orders"),
        ),
        body: ListView.builder(
            itemCount: _orderProvider.pendingOrderList.length,
            itemBuilder: (context, index) {
              final orders = _orderProvider.pendingOrderList[index];

              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                        context, PendingOrderDetailsPage.routeName,
                        arguments: [
                          orders.orderId,
                          orders.grandTotal,
                          orders.paymentMethod,
                          orders.orderStatus,
                          orders.deliveryName,
                          orders.deliveryPhone,
                          orders.deliveryAddress
                        ]);
                  },
                  title: Text(orders.deliveryName),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(orders.deliveryAddress),
                      SizedBox(
                        width: 30,
                      ),
                      Text(orders.deliveryPhone),
                    ],
                  ),
                ),
              );
            }));
  }
}

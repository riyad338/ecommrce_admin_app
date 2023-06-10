import 'package:ecommerce_own/pages/all_distributor_order_details.dart';
import 'package:ecommerce_own/pages/all_order_details_page.dart';
import 'package:ecommerce_own/pages/pending_order_details_page.dart';
import 'package:ecommerce_own/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllDistributorOrdersPage extends StatefulWidget {
  static const String routeName = '/all_distributor_order';

  @override
  State<AllDistributorOrdersPage> createState() =>
      _AllDistributorOrdersPageState();
}

class _AllDistributorOrdersPageState extends State<AllDistributorOrdersPage> {
  String order = "Delivered";
  late OrderProvider _orderProvider;

  @override
  void didChangeDependencies() {
    _orderProvider = Provider.of<OrderProvider>(context);
    _orderProvider.getAllDistributorOrders();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text("All Orders"),
        ),
        body: ListView.builder(
            itemCount: _orderProvider.distributorOrderList.length,
            itemBuilder: (context, index) {
              final orders = _orderProvider.distributorOrderList[index];

              return Card(
                child: ListTile(
                    tileColor: orders.orderStatus == order
                        ? Colors.green
                        : Colors.redAccent,
                    onTap: () {
                      Navigator.pushNamed(
                          context, AllDistributorOrderDetailsPage.routeName,
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
                    subtitle: Text(orders.deliveryAddress),
                    trailing: Chip(
                      label: Text(orders.orderStatus),
                    )),
              );
            }));
  }
}

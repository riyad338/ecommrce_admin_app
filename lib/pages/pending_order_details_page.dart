import 'package:ecommerce_own/providers/order_provider.dart';
import 'package:ecommerce_own/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingOrderDetailsPage extends StatefulWidget {
  static const String routeName = '/pending_order_details';

  @override
  State<PendingOrderDetailsPage> createState() =>
      _PendingOrderDetailsPageState();
}

class _PendingOrderDetailsPageState extends State<PendingOrderDetailsPage> {
  final _pendingController = TextEditingController();

  String? _orderId;
  String? _paymentMethod;
  String? _orderStatus;
  String? _orderName;
  String? _orderPhone;
  String? _orderAddress;
  num? _total;

  String? dropdownvalue;

  var items = [
    'Pending',
    'Packaging',
    'On The way',
  ];
  late OrderProvider _orderProvider;
  @override
  void didChangeDependencies() {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    _orderId = argList[0];
    _total = argList[1];
    _paymentMethod = argList[2];
    _orderStatus = argList[3];
    _orderName = argList[4];
    _orderPhone = argList[5];
    _orderAddress = argList[6];
    _orderProvider = Provider.of<OrderProvider>(context);
    _orderProvider.getOrderPendingDetails(_orderId!);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pendingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _orderProvider.updateOrderStatus(_orderId!, dropdownvalue!);
                Navigator.pop(context);
              },
              icon: Icon(Icons.save))
        ],
        backgroundColor: Colors.greenAccent,
        title: Text('Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: ListView(
              children: [
                ListTile(
                  title: Text("Name :   ${_orderName}"),
                ),
                ListTile(
                  title: Text("Address :   ${_orderAddress}"),
                ),
                ListTile(
                  title: Text("Phone Number :  ${_orderPhone}"),
                ),
                ListTile(
                  title: Text("${_paymentMethod}"),
                ),
                ListTile(
                  title: Text("Total :  $takaSymbol ${_total}"),
                ),
                ListTile(
                  title: Text("Order Status:   ${_orderStatus}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      border: OutlineInputBorder(),
                    ),
                    hint: Text('Select Order Status'),
                    value: dropdownvalue,
                    onChanged: (value) {
                      setState(() {
                        dropdownvalue = value;
                      });
                    },
                    onSaved: (value) {
                      dropdownvalue = value;
                    },
                    items: items
                        .map((status) => DropdownMenuItem(
                              child: Text(status),
                              value: status,
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Order Items",
            style: TextStyle(fontSize: 20),
          ),
          Divider(
            color: Colors.black,
          ),
          Expanded(
            flex: 6,
            child: ListView.builder(
              itemCount: _orderProvider.orderPendingDetailsList.length,
              itemBuilder: (context, index) {
                final details = _orderProvider.orderPendingDetailsList[index];
                return Column(
                  children: [
                    Card(
                      child: ListTile(
                        subtitle: Text("$takaSymbol ${details.price}"),
                        title: Text(details.productName),
                        trailing: Text('Quantity  ${details.qty}'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

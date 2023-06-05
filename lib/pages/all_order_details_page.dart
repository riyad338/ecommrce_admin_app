import 'package:ecommerce_own/models/order_model.dart';
import 'package:ecommerce_own/providers/order_provider.dart';
import 'package:ecommerce_own/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllOrderDetailsPage extends StatefulWidget {
  static const String routeName = '/all_order_details';

  @override
  State<AllOrderDetailsPage> createState() => _AllOrderDetailsPageState();
}

class _AllOrderDetailsPageState extends State<AllOrderDetailsPage> {
  TextEditingController _statusController = TextEditingController();
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
    'Delivered',
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
    _orderProvider.getOrderDetails(_orderId!);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _statusController.dispose();
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
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Update Order Status")));
                Navigator.pop(context);
              },
              icon: Icon(Icons.save))
        ],
        backgroundColor: Colors.greenAccent,
        title: Text('Details'),
      ),
      body: Column(
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
              itemCount: _orderProvider.orderDetailsList.length,
              itemBuilder: (context, index) {
                final details = _orderProvider.orderDetailsList[index];
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

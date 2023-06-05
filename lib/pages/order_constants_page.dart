import 'package:ecommerce_own/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderConstantsPage extends StatefulWidget {
  static const String routeName = '/order_constants';

  @override
  State<OrderConstantsPage> createState() => _OrderConstantsPageState();
}

class _OrderConstantsPageState extends State<OrderConstantsPage> {
  final _vatController = TextEditingController();
  final _chargeController = TextEditingController();
  final _discountController = TextEditingController();
  late OrderProvider _orderProvider;
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _orderProvider = Provider.of<OrderProvider>(context);
      _orderProvider.getOrderConstants().then((value) {
        if (value != null) {
          _vatController.text = value.vat.toString();
          _discountController.text = value.discount.toString();
          _chargeController.text = value.deliveryCharge.toString();
          setState(() {});
        }
      });
    }

    // _vatController.text = _orderProvider.orderConstantsModel.vat.toString();
    // _chargeController.text =
    //     _orderProvider.orderConstantsModel.deliveryCharge.toString();
    // _discountController.text =
    //     _orderProvider.orderConstantsModel.discount.toString();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Order Constants"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Vat"),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder()),
              controller: _vatController,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Discount"),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder()),
              controller: _discountController,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Delivrey Charge"),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder()),
              controller: _chargeController,
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.greenAccent,
                minWidth: double.infinity,
                height: 50,
                onPressed: () {
                  updateConstants();
                },
                child: Text("Update")),
          ],
        ),
      ),
    );
  }

  void updateConstants() {
    _orderProvider.updateOrderConstants(
      int.parse(_chargeController.text),
      int.parse(_vatController.text),
      int.parse(_discountController.text),
    );
  }
}

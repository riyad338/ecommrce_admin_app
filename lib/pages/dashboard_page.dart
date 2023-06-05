import 'package:ecommerce_own/auth/firebase_auth_service.dart';
import 'package:ecommerce_own/custom_widgets/dashboard_button.dart';
import 'package:ecommerce_own/pages/all_distributor_order_list.dart';
import 'package:ecommerce_own/pages/all_order_list_page.dart';
import 'package:ecommerce_own/pages/categorie_add.dart';
import 'package:ecommerce_own/pages/distributor_product_list_page.dart';
import 'package:ecommerce_own/pages/login_page.dart';
import 'package:ecommerce_own/pages/order_constants_page.dart';
import 'package:ecommerce_own/pages/pending_order_page.dart';
import 'package:ecommerce_own/pages/update_product_page.dart';
import 'package:ecommerce_own/providers/order_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import 'new_product_page.dart';
import 'product_list_page.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/dashboard';

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late ProductProvider _productProvider;
  late OrderProvider _orderProvider;
  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _productProvider.init();
    _orderProvider = Provider.of<OrderProvider>(context);
    // _orderProvider.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuthService.logoutAdmin().then((value) =>
                  Navigator.pushReplacementNamed(context, LoginPage.routeName));
            },
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        children: [
          DashboardButton(
            label: 'Add Product',
            onPressed: () =>
                Navigator.pushNamed(context, NewProductPage.routeName),
          ),
          DashboardButton(
            label: 'View User Product',
            onPressed: () =>
                Navigator.pushNamed(context, ProductListPage.routeName),
          ),
          DashboardButton(
            label: 'Update User\n   Product',
            onPressed: () =>
                Navigator.pushNamed(context, UpdateProductPage.routeName),
          ),
          DashboardButton(
            label: 'Update Distributor\n        Product',
            onPressed: () => Navigator.pushNamed(
                context, DistributorProductListPage.routeName),
          ),
          DashboardButton(
            label: 'Pending User\n     Orders',
            onPressed: () =>
                Navigator.pushNamed(context, PendingOrderPage.routeName),
          ),
          DashboardButton(
            label: 'All User Orders',
            onPressed: () =>
                Navigator.pushNamed(context, AllOrdersPage.routeName),
          ),
          DashboardButton(
            label: 'All Distributor\n      Orders',
            onPressed: () => Navigator.pushNamed(
                context, AllDistributorOrdersPage.routeName),
          ),
          DashboardButton(
            label: 'Categories Page',
            onPressed: () =>
                Navigator.pushNamed(context, CategorieAddPage.routeName),
          ),
          DashboardButton(
            label: 'OrderConstants',
            onPressed: () =>
                Navigator.pushNamed(context, OrderConstantsPage.routeName),
          ),
        ],
      ),
    );
  }
}

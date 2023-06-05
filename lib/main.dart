import 'package:ecommerce_own/pages/all_distributor_order_details.dart';
import 'package:ecommerce_own/pages/all_distributor_order_list.dart';
import 'package:ecommerce_own/pages/all_order_details_page.dart';
import 'package:ecommerce_own/pages/all_order_list_page.dart';
import 'package:ecommerce_own/pages/categorie_add.dart';
import 'package:ecommerce_own/pages/dashboard_page.dart';
import 'package:ecommerce_own/pages/distributor_product_list_page.dart';
import 'package:ecommerce_own/pages/distributors_update_product_details_page.dart';

import 'package:ecommerce_own/pages/launcher_page.dart';
import 'package:ecommerce_own/pages/login_page.dart';
import 'package:ecommerce_own/pages/new_product_page.dart';
import 'package:ecommerce_own/pages/order_constants_page.dart';
import 'package:ecommerce_own/pages/pending_order_details_page.dart';
import 'package:ecommerce_own/pages/pending_order_page.dart';
import 'package:ecommerce_own/pages/product_details_page.dart';
import 'package:ecommerce_own/pages/product_list_page.dart';
import 'package:ecommerce_own/pages/update_product_details_page.dart';
import 'package:ecommerce_own/pages/update_product_page.dart';
import 'package:ecommerce_own/providers/order_provider.dart';
import 'package:ecommerce_own/providers/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(elevation: 0),
          primarySwatch: Colors.blue,
        ),
        home: LauncherPage(),
        routes: {
          LauncherPage.routeName: (context) => LauncherPage(),
          LoginPage.routeName: (context) => LoginPage(),
          DashboardPage.routeName: (context) => DashboardPage(),
          NewProductPage.routeName: (context) => NewProductPage(),
          ProductListPage.routeName: (context) => ProductListPage(),
          ProductDetailsPage.routeName: (context) => ProductDetailsPage(),
          UpdateProductPage.routeName: (context) => UpdateProductPage(),
          UpdateProductDetailsPage.routeName: (context) =>
              UpdateProductDetailsPage(),
          CategorieAddPage.routeName: (context) => CategorieAddPage(),
          PendingOrderPage.routeName: (context) => PendingOrderPage(),
          PendingOrderDetailsPage.routeName: (context) =>
              PendingOrderDetailsPage(),
          AllOrdersPage.routeName: (Context) => AllOrdersPage(),
          AllOrderDetailsPage.routeName: (Context) => AllOrderDetailsPage(),
          OrderConstantsPage.routeName: (context) => OrderConstantsPage(),
          AllDistributorOrdersPage.routeName: (context) =>
              AllDistributorOrdersPage(),
          AllDistributorOrderDetailsPage.routeName: (context) =>
              AllDistributorOrderDetailsPage(),
          DistributorProductListPage.routeName: (context) =>
              DistributorProductListPage(),
          UpdateDistributorProductDetailsPage.routeName: (context) =>
              UpdateDistributorProductDetailsPage(),
        },
      ),
    );
  }
}

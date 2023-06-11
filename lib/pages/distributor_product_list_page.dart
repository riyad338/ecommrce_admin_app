import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_own/pages/distributors_update_product_details_page.dart';
import 'package:ecommerce_own/pages/product_details_page.dart';
import 'package:ecommerce_own/pages/update_product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../utils/constants.dart';

class DistributorProductListPage extends StatefulWidget {
  static const String routeName = '/distributor_products_update';

  @override
  _DistributorProductListPageState createState() =>
      _DistributorProductListPageState();
}

class _DistributorProductListPageState
    extends State<DistributorProductListPage> {
  late ProductProvider _productProvider;

  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text('Update Distributor Product'),
      ),
      body: _productProvider.distributorProductList.isEmpty
          ? Center(
              child: Text('No items found'),
            )
          : ListView.builder(
              itemCount: _productProvider.distributorProductList.length,
              itemBuilder: (context, index) {
                final product = _productProvider.distributorProductList[index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context,
                            UpdateDistributorProductDetailsPage.routeName,
                            arguments: [product.id, product.name]);
                      },
                      title: Text(product.name!),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: CachedNetworkImage(
                          imageUrl: product.imageDownloadUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => SpinKitFadingCircle(
                            color: Colors.greenAccent,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      trailing: Chip(
                        label: Text('$takaSymbol${product.price}'),
                      )),
                );
              },
            ),
    );
  }
}

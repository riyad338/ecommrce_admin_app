import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_own/models/product_model.dart';
import 'package:ecommerce_own/providers/product_provider.dart';
import 'package:ecommerce_own/utils/constants.dart';
import 'package:ecommerce_own/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class UpdateDistributorProductDetailsPage extends StatefulWidget {
  static const String routeName = '/distributor_product_details_update';

  @override
  State<UpdateDistributorProductDetailsPage> createState() =>
      _UpdateDistributorProductDetailsPageState();
}

class _UpdateDistributorProductDetailsPageState
    extends State<UpdateDistributorProductDetailsPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _offerController = TextEditingController();
  String? productId;
  String productName = '';
  late ProductProvider _productProvider;
  bool producthave = true;

  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    productId = argList[0];
    productName = argList[1];
    super.didChangeDependencies();
  }

  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _offerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        actions: [
          IconButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  _updateProductDetails();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Update your prodct")));
                }
              },
              icon: Icon(Icons.save))
        ],
        title: Text("$productName Update"),
      ),
      body: Form(
        key: formkey,
        child: Center(
          child: Consumer<ProductProvider>(builder: (context, provider, _) {
            return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: provider.getDistributorProductByProductId(productId!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final product = ProductModel.fromMap(snapshot.data!.data()!);

                  _nameController.text = product.name!;
                  _descriptionController.text = product.description!;
                  _offerController.text = product.offer!;
                  _priceController.text = product.price.toString();

                  return ListView(
                    children: [
                      CachedNetworkImage(
                        imageUrl: product.imageDownloadUrl!,
                        fit: BoxFit.cover,
                        height: 250,
                        placeholder: (context, url) => SpinKitFadingCircle(
                          color: Colors.greenAccent,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Name");
                            }
                          },
                          decoration: InputDecoration(
                            label: Text("Name"),
                            suffixIcon: Icon(Icons.edit),
                            contentPadding: EdgeInsets.all(10),
                            focusedBorder: _outLineBorder(),
                            enabledBorder: _outLineBorder(),
                          ),
                          controller: _nameController,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Price");
                            }
                          },
                          decoration: InputDecoration(
                            label: Text("Price"),
                            suffixIcon: Icon(Icons.edit),
                            contentPadding: EdgeInsets.all(10),
                            focusedBorder: _outLineBorder(),
                            enabledBorder: _outLineBorder(),
                          ),
                          controller: _priceController,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            label: Text("Offer"),
                            suffixIcon: Icon(Icons.edit),
                            contentPadding: EdgeInsets.all(10),
                            focusedBorder: _outLineBorder(),
                            enabledBorder: _outLineBorder(),
                          ),
                          controller: _offerController,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Description");
                            }
                          },
                          decoration: InputDecoration(
                            label: Text("Description"),
                            contentPadding: EdgeInsets.all(10),
                            suffixIcon: Icon(Icons.edit),
                            focusedBorder: _outLineBorder(),
                            enabledBorder: _outLineBorder(),
                          ),
                          controller: _descriptionController,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: ListTile(
                          tileColor: product.isAvailable == true
                              ? Colors.green
                              : Colors.redAccent,
                          title: Text(product.isAvailable == true
                              ? "Available"
                              : "Not Available"),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                bool update = producthave = !producthave;
                                _productProvider
                                    .updateDistributorProductIsAvailableorNot(
                                        product.id!, update);
                              });
                            },
                            icon: Icon(product.isAvailable == true
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return const Text('Failed to load data');
                }
                return CircularProgressIndicator();
              },
            );
          }),
        ),
      ),
    );
  }

  _outLineBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent),
      borderRadius: BorderRadius.circular(15),
    );
  }

  _updateProductDetails() {
    _productProvider.updateDistributorProduct(
        productId!,
        _nameController.text,
        _descriptionController.text,
        _offerController.text,
        int.parse(_priceController.text));
  }
}

import 'package:ecommerce_own/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorieAddPage extends StatefulWidget {
  static const String routeName = '/categoris';

  @override
  State<CategorieAddPage> createState() => _CategorieAddPageState();
}

class _CategorieAddPageState extends State<CategorieAddPage> {
  TextEditingController _categorieController = TextEditingController();
  late ProductProvider _productProvider;
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _categorieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Categories"),
      ),
      body: ListView.builder(
          itemCount: _productProvider.categoryList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              child: ListTile(
                title: Text("${_productProvider.categoryList[index]}"),
                trailing: IconButton(
                  onPressed: () {
                    _productProvider.deleteCategorie(
                        "${_productProvider.categoryList[index]}");
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            _showDialog(context);
          },
          child: Icon(Icons.add)),
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 20,
          title: Text("Add new categories"),
          content: TextFormField(
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.edit),
              hintText: "Add Categories",
            ),
            controller: _categorieController,
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 20,
            ),
            ElevatedButton(
              child: Text("Add"),
              onPressed: () {
                _addNewCategorie();
              },
            ),
          ],
        );
      },
    );
  }

  _addNewCategorie() {
    _productProvider.addNewCategorie(
        _categorieController.text, _categorieController.text);
    Navigator.pop(context);
    _categorieController.clear();
  }
}

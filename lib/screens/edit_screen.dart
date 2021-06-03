import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/providers/product.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';

class EditScreen extends StatefulWidget {
  static String routeName = "edititem";

  const EditScreen({Key key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  final imageUrlController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    priceController.dispose();
    descController.dispose();
    imageUrlController.dispose();
  }git

  @override
  Widget build(BuildContext context) {
    final provider = context.read<Products>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                validator: (value) {
                  return titleController.text.isEmpty
                      ? "Please Add Title"
                      : null;
                },
                decoration: InputDecoration(
                  labelText: "Product Name",
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  _priceFocus.requestFocus();
                },
              ),
              TextFormField(
                focusNode: _priceFocus,
                validator: (val) {
                  return priceController.text.toString().isEmpty
                      ? "Price is empty"
                      : (double.parse(priceController.text.toString()) < 0
                          ? "Your value is negative"
                          : null);
                },
                controller: priceController,
                decoration: InputDecoration(
                  labelText: "Price",
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) {
                  _descriptionFocus.requestFocus();
                },
              ),
              TextFormField(
                focusNode: _descriptionFocus,
                controller: descController,
                validator: (value) {
                  return descController.text.isEmpty
                      ? "Please Add Description"
                      : null;
                },
                decoration: InputDecoration(
                  labelText: "Decription",
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onFieldSubmitted: (_) {
                  _imageUrlFocus.requestFocus();
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    child: imageUrlController.text.isNotEmpty
                        ? Image.network(imageUrlController.text.toString())
                        : Center(child: Text("Image Url")),
                  ),
                  Expanded(
                    child: TextFormField(
                      focusNode: _imageUrlFocus,
                      controller: imageUrlController,
                      validator: (value) {
                        return imageUrlController.text.isEmpty
                            ? "Please Add Description"
                            : null;
                      },
                      decoration: InputDecoration(
                          labelText: "Image Url",
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder()),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.url,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                onPressed: () {
                  if (formkey.currentState.validate()) {
                    Product product = Product(
                        id: "product1",
                        title: titleController.text,
                        description: descController.text,
                        price: double.parse(priceController.text.toString()),
                        imageUrl: imageUrlController.text);
                    provider.addProduct(product);
                    Fluttertoast.showToast(
                        msg: "Your Prodcut has been Added",
                        fontSize: 15,
                        backgroundColor: Colors.green,
                        textColor: Colors.white);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "Add Product",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}

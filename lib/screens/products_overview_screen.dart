import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/products.dart';

import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    @override
    final productdata = context.watch<Products>(); // listen true
    // final product = context.read<Products>(); //listen false
    final itemsData = productdata.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          productdata.addProduct(Product(
            id: 'p1',
            title: 'white',
            description: 'A red shirt - it is pretty red!',
            price: 29.99,
            imageUrl:
            'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          ));
        },
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: itemsData.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider(
          create: (_) =>itemsData[i],
          child: ProductItem(
          ),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}



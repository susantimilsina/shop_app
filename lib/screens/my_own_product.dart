import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/screens/edit_screen.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/myproduct_item.dart';

class MyOwnProduct extends StatelessWidget {
  static final String routeName = "ownproduct";

  const MyOwnProduct({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myproduct = context.watch<Products>();
    return Scaffold(
      appBar: AppBar(
        title: Text("My Product"),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, EditScreen.routeName);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: myproduct.items.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              MyItem(
                itemName: myproduct.items[index].title,
                itemUrl: myproduct.items[index].imageUrl,
                itemid: myproduct.items[index].id,
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';

class MyItem extends StatelessWidget {
  String itemUrl;
  String itemName;
  String itemid;

  MyItem({Key key, this.itemName, this.itemUrl, this.itemid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Products>(context, listen: true);
    return Container(
      width: double.infinity,
      child: ListTile(
        leading: Image.network(
          itemUrl,
          width: 100,
        ),
        title: Text(itemName),
        trailing: Container(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.edit,
                color: Colors.green,
              ),
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    provider.deleteId(itemid);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

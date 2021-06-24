import 'package:flutter/material.dart';
import 'package:myshop/providers/products.dart';
import 'package:myshop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

import '../screens/user_products_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                color: Theme.of(context).primaryColor,
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            elevation: 5,
                            title: Text("Are you sure?"),
                            content: Text(
                              "You want to delete",
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text("No",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).errorColor))),
                              TextButton(
                                  onPressed: () {
                                    Provider.of<Products>(context,
                                            listen: false)
                                        .removeProduct(id);
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text("Yes",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).errorColor))),
                            ],
                          ));
                },
                color: Theme.of(context).errorColor,
                icon: Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}

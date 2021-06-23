import 'package:flutter/material.dart';
import 'package:myshop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "./user_product_screen";

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (ctx, i) => UserProductItem(
                productData.items[i].title, productData.items[i].imageUrl)),
      ),
    );
  }
}

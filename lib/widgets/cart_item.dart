import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItem(
      this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, size: 40, color: Colors.white),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          right: 20,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Are you sure?"),
                  content: Text("Do you want to remove item from the cart?"),
                  actions: [
                    TextButton(onPressed: () {
                      Navigator.of(context).pop(false);
                    }, child: Text("No", style: TextStyle(color: Colors.red),)),
                    TextButton(onPressed: () {
                      Navigator.of(context).pop(true);
                    }, child: Text("Yes",style: TextStyle(color: Colors.red)))
                  ],
                ));
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("\$$price"),
              )),
            ),
            title: Text("$title"),
            subtitle: Text("Total: \$${(price * quantity).round()}"),
            trailing: Text('$quantity X'),
          ),
        ),
      ),
    );
  }
}

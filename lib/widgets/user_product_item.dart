import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserProductItem(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation:2,
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
                onPressed: () {},
                color:Theme.of(context).primaryColor,
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {},
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

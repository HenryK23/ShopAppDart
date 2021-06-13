import 'package:flutter/material.dart';
import 'package:http_request/providers/products.dart';
import 'package:http_request/screens/edit_product_screen.dart';

import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  String? id = "";
  final String title;
  final String imageURL;

  UserProductItem(this.id, this.title, this.imageURL);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageURL),
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
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                      content: Text(
                    "Deleting Failed!",
                    textAlign: TextAlign.center,
                  )));
                }
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}

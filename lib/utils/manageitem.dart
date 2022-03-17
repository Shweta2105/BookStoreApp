import 'package:bookstoreapp/providers/books.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;

  ManageItem(this.id, this.title, this.image);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(image),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                )),
            IconButton(
                onPressed: () {
                  Provider.of<Books>(context, listen: false).deleteBook(id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ))
          ],
        ),
      ),
    );
  }
}

import 'package:bookstoreapp/providers/books.dart';
import 'package:bookstoreapp/screens/editbookscreen.dart';
import 'package:bookstoreapp/utils/manageitem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bookstoreapp/utils/appdrawer.dart';

class ManageScreen extends StatelessWidget {
  static const routeName = '/manageScreen';

  Future<void> _refreshBooks(BuildContext context) async {
    final productData =
        await Provider.of<Books>(context, listen: false).fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    final bookData = Provider.of<Books>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Product'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(EditBookScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshBooks(context),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: bookData.item.length,
              itemBuilder: (_, i) => Column(
                    children: [
                      ManageItem(bookData.item[i].id, bookData.item[i].title,
                          bookData.item[i].image),
                      Divider(),
                    ],
                  )),
        ),
      ),
    );
  }
}

import 'package:bookstoreapp/providers/book.dart';
import 'package:bookstoreapp/providers/books.dart';
import 'package:bookstoreapp/screens/home.dart';
import 'package:bookstoreapp/utils/bookcard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookData = Provider.of<Books>(context);
    print('========${bookData.item}============');
    final book = fliterBooks.isEmpty ? bookData.item : fliterBooks;
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2 / 3),
        itemCount:
            fliterBooks.isEmpty ? bookData.item.length : fliterBooks.length,
        itemBuilder: (BuildContext context, int index) =>
            ChangeNotifierProvider.value(
              value: book[index],
              child: BookCard(),
            ));
  }
}

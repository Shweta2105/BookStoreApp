import 'package:bookstoreapp/model/books.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:flutter/material.dart';

class DisplayDetails extends StatelessWidget {
  Books books;
  DisplayDetails({
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        books.title!,
        style: const TextStyle(fontSize: fontM),
      ),
    );
  }
}

import 'package:bookstoreapp/providers/book.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:flutter/material.dart';

RaisedButton cartButton() {
  return RaisedButton(
    onPressed: () {},
    child: const Text(
      'Add to Cart',
      style: TextStyle(
        fontSize: fontS,
      ),
    ),
    color: titleColor,
  );
}

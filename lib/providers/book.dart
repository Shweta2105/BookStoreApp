import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Book {
  final String id;
  final String image;
  final String title;
  final String author;
  final double price;
  bool isFavourite;

  Book(
      {required this.id,
      required this.image,
      required this.title,
      required this.author,
      required this.price,
      this.isFavourite = false});

  void toggleIsFavourite() {
    isFavourite = !isFavourite;
  }
}
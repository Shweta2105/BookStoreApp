import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Book {
  final String id;
  final String image;
  final String title;
  final String author;
  final String price;
  bool isFavourite;

  Book(
      {required this.id,
      required this.image,
      required this.title,
      required this.author,
      required this.price,
      this.isFavourite = false});

  // factory Book.fromJson(Map<String, dynamic> json) {
  //   return Book(
  //     id: json['id'],
  //     image: json['image'],
  //     title: json['title'],
  //     author: json['author'],
  //     price: json['price'],
  //   );
  //}
}

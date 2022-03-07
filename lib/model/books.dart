import 'dart:convert';

import 'package:flutter/services.dart';

class Books {
  String? id;
  String? image;
  String? title;
  String? author;
  String? price;

  Books({
    this.id,
    this.image,
    this.title,
    this.author,
    this.price,
  });

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      author: json['author'],
      price: json['price'],
    );
  }
}

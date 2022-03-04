import 'dart:convert';

import 'package:flutter/services.dart';

class Books {
  String? id;
  String? image;
  String? title;
  String? author;
  String? price;
  List? wishlist;
  List? orders;

  Books(
      {this.id,
      this.image,
      this.title,
      this.author,
      this.price,
      this.wishlist,
      this.orders});

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
        id: json['id'],
        image: json['image'],
        title: json['title'],
        author: json['author'],
        price: json['price'],
        wishlist: json['wishlist'],
        orders: json['orders']);
  }
}

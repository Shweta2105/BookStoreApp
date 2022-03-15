import 'package:bookstoreapp/providers/book.dart';
import 'package:bookstoreapp/service/auth/auth_service.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:flutter/material.dart';

RaisedButton cartButton() {
  return RaisedButton(
    onPressed: () {},
    child: Text(
      'Add to Cart',
      style: const TextStyle(
        fontSize: fontS,
      ),
    ),
    color: titleColor,
  );
}

TextButton wishlistButton(Book book) {
  return TextButton(
      onPressed: () async {
        AuthService.firebase().updateWishlist(book: book);
        print("-------------------in wishlist button---------");
      },
      child: Row(
        children: [
          Text(
            'Add to WishList',
            style: TextStyle(color: black),
          ),
          Icon(
            Icons.favorite_outline_outlined,
            color: black,
          ),
        ],
      ));
}

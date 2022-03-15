import 'package:bookstoreapp/providers/book.dart';
import 'package:flutter/material.dart';

class Books with ChangeNotifier {
  final List<Book> _item = [
    Book(
      id: "1",
      image: "assets/images/book_18.jpg",
      title: "Building Planning",
      author: "S. S. Bhavikatti",
      price: "1400",
    ),
    Book(
      id: "2",
      image: "assets/images/book_20.jpg",
      title: "Civil Engineering",
      author: "S. P. Gupta",
      price: "1200",
    ),
    Book(
        id: "3",
        image: "assets/images/book_21.jpg",
        title: "Surveying",
        author: "S. K. Duggal",
        price: "1000"),
    Book(
      id: "5",
      image: "assets/images/book_4.jpg",
      title: "Rising hear",
      author: "Perumal",
      price: "400",
    ),
    Book(
        id: "6",
        image: "assets/images/book_5.png",
        title: "Just like you",
        author: "Nick Hornby",
        price: "500"),
    Book(
        id: "7",
        image: "assets/images/book_6.png",
        title: "Richest man",
        author: "George S. Clason",
        price: "600"),
    Book(
        id: "9",
        image: "assets/images/book_8.jpg",
        title: "Chinese Communist",
        author: "Handry",
        price: "200"),
    Book(
        id: "10",
        image: "assets/images/book_22.jpg",
        title: "Think like a Rocket",
        author: "Panik H.",
        price: "800"),
    Book(
        id: "11",
        image: "assets/images/book_10.jpg",
        title: "How to speak",
        author: "Ron Malhotra",
        price: "850"),
    Book(
        id: "12",
        image: "assets/images/book_11.jpg",
        title: "Wining like Sourav",
        author: "Abhirup B.",
        price: "880"),
    Book(
        id: "13",
        image: "assets/images/book_12.jpg",
        title: "Oxfort Avanced",
        author: "Ajit J.",
        price: "1100"),
    Book(
        id: "14",
        image: "assets/images/book_13.jpg",
        title: "Tip of the Iceberg",
        author: "Suveen Sinha",
        price: "690"),
    Book(
        id: "15",
        image: "assets/images/book_14.jpg",
        title: "How to read a book",
        author: "Nortimer J. Adler",
        price: "780"),
    Book(
        id: "16",
        image: "assets/images/book_15.jpg",
        title: "Winning Sachin",
        author: "Devendra P.",
        price: "450")
  ];

  List<Book> get item {
    return [..._item];
  }

  Book findById(String id) {
    return _item.firstWhere((book) => book.id == id);
  }
}

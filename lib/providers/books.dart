import 'package:bookstoreapp/model/httpexecption.dart';
import 'package:bookstoreapp/providers/book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Books with ChangeNotifier {
  final String authToken;
  final String userId;
  Books(this.authToken, this.userId, this._item);

  List<Book> _item = [
    // Book(
    //   id: "1",
    //   image: "assets/images/book_18.jpg",
    //   title: "Building Planning",
    //   author: "S. S. Bhavikatti",
    //   price: 1400,
    // ),
    // Book(
    //   id: "2",
    //   image: "assets/images/book_20.jpg",
    //   title: "Civil Engineering",
    //   author: "S. P. Gupta",
    //   price: 1200,
    // ),
    // Book(
    //     id: "3",
    //     image: "assets/images/book_21.jpg",
    //     title: "Surveying",
    //     author: "S. K. Duggal",
    //     price: 1000),
    // Book(
    //   id: "5",
    //   image: "assets/images/book_4.jpg",
    //   title: "Rising hear",
    //   author: "Perumal",
    //   price: 400,
    // ),
    // Book(
    //     id: "6",
    //     image: "assets/images/book_5.png",
    //     title: "Just like you",
    //     author: "Nick Hornby",
    //     price: 500),
    // Book(
    //     id: "7",
    //     image: "assets/images/book_6.png",
    //     title: "Richest man",
    //     author: "George S. Clason",
    //     price: 600),
    // Book(
    //     id: "9",
    //     image: "assets/images/book_8.jpg",
    //     title: "Chinese Communist",
    //     author: "Handry",
    //     price: 200),
    // Book(
    //     id: "10",
    //     image: "assets/images/book_22.jpg",
    //     title: "Think like a Rocket",
    //     author: "Panik H.",
    //     price: 800),
    // Book(
    //     id: "11",
    //     image: "assets/images/book_10.jpg",
    //     title: "How to speak",
    //     author: "Ron Malhotra",
    //     price: 850),
    // Book(
    //     id: "12",
    //     image: "assets/images/book_11.jpg",
    //     title: "Wining like Sourav",
    //     author: "Abhirup B.",
    //     price: 880),
    // Book(
    //     id: "13",
    //     image: "assets/images/book_12.jpg",
    //     title: "Oxfort Avanced",
    //     author: "Ajit J.",
    //     price: 1100),
    // Book(
    //     id: "14",
    //     image: "assets/images/book_13.jpg",
    //     title: "Tip of the Iceberg",
    //     author: "Suveen Sinha",
    //     price: 690),
    // Book(
    //     id: "15",
    //     image: "assets/images/book_14.jpg",
    //     title: "How to read a book",
    //     author: "Nortimer J. Adler",
    //     price: 780),
    // Book(
    //     id: "16",
    //     image: "assets/images/book_15.jpg",
    //     title: "Winning Sachin",
    //     author: "Devendra P.",
    //     price: 450)
  ];

  List<Book> get item {
    return [..._item];
  }

  Book findById(String id) {
    return _item.firstWhere((book) => book.id == id);
  }

  Future<void> fetchBooks() async {
    var url =
        'https://bookstoreapp-1-default-rtdb.asia-southeast1.firebasedatabase.app/bookstore.json?auth=$authToken';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Book> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      print("------------fetch method");
      print(authToken);
      print(response.statusCode);
      print(response.body);
      print('----------------------');
      print('userId--------${userId}----------');
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Book(
            id: prodId,
            title: prodData['title'],
            author: prodData['author'],
            price: prodData['price'],
            isFavourite: prodData['isFavourite'],
            image: prodData['image']));
      });
      _item = loadedProducts;
      print(_item);
      notifyListeners();
    } catch (e) {
      print(e);
      // throw (e);
    }
  }

  Future<void> addBooks(Book book) async {
    var url =
        'https://bookstoreapp-1-default-rtdb.asia-southeast1.firebasedatabase.app/bookstore.json?auth=$authToken';
    try {
      final response = await http.post(
        (Uri.parse(url)),
        body: json.encode({
          'title': book.title,
          'author': book.author,
          'image': book.image,
          'price': book.price,
        }),
      );
      print(json.decode(response.body));
      final newProduct = Book(
        id: json.decode(response.body)['name'],
        title: book.title,
        author: book.author,
        price: book.price,
        image: book.image,
      );
      _item.add(newProduct);
      notifyListeners();
    } catch (onError) {
      print(onError);
      throw onError;
    }
  }

  Future<void> addBook(Book book) async {
    var url =
        'https://bookstoreapp-1-default-rtdb.asia-southeast1.firebasedatabase.app/bookstore.json?auth=$authToken';
    try {
      final response = await http.post(
        (Uri.parse(url)),
        body: json.encode({
          'title': book.title,
          'author': book.author,
          'image': book.image,
          'price': book.price,
          'userId': userId,
        }),
      );

      print(json.decode(response.body));
      final newProduct = Book(
        id: json.decode(response.body)['name'],
        title: book.title,
        author: book.author,
        price: book.price,
        image: book.image,
      );
      _item.add(newProduct);
      notifyListeners();
    } catch (onError) {
      print(onError);
      throw onError;
    }
  }

  Future<void> updateBook(String id, Book newBook) async {
    final prodIndex = _item.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      var url =
          'https://bookstoreapp-1-default-rtdb.asia-southeast1.firebasedatabase.app/bookstore/$id.json?auth=$authToken';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newBook.title,
            'author': newBook.author,
            'image': newBook.image,
            'price': newBook.price,
          }));
      _item[prodIndex] = newBook;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteBook(String id) async {
    var url =
        'https://bookstoreapp-1-default-rtdb.asia-southeast1.firebasedatabase.app/bookstore/$id.json?auth=$authToken';
    final existingProductIndex = _item.indexWhere((prod) => prod.id == id);
    Book? existingProduct = _item[existingProductIndex];
    _item.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode >= 400) {
      _item.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existingProduct = null;
  }
}

import 'dart:convert';
import 'package:bookstoreapp/model/books.dart';
import 'package:bookstoreapp/screens/cart.dart';
import 'package:bookstoreapp/utils/bookcard.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:bookstoreapp/utils/customappbar.dart';
//import 'package:bookstoreapp/utils/customappbar.dart';
import 'package:bookstoreapp/utils/custompopmenu.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var searchString;
TextEditingController searchcontroller = TextEditingController();
List<Books> _books = [];
List<Books> fliterBooks = [];

class _HomeScreenState extends State<HomeScreen> {
  List list = [];
  Future<List<Books>> getBooks() async {
    final data =
        await DefaultAssetBundle.of(context).loadString('assets/books.json');
    final response = json.decode(data);
    var res = response as List<dynamic>;
    List<Books> bookList = res.map((e) => Books.fromJson(e)).toList();
    return bookList;
  }

  void searchMethod(String value) {
    return setState(() {
      searchString = value.toLowerCase();

      fliterBooks = _books
          .where(
              (element) => element.title!.toLowerCase().contains(searchString))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getBooks().then((value) {
      setState(() {
        _books = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getBooks();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onSearchChange: (value) {
          print("************value in home screen ${value}********");
          searchMethod(value);
        },
      ),
      body: displayList(),
    );
  }

  GridView displayList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2 / 3),
        itemCount: fliterBooks.isEmpty ? _books.length : fliterBooks.length,
        itemBuilder: (BuildContext context, int index) {
          Books book = fliterBooks.isEmpty ? _books[index] : fliterBooks[index];

          return BookCard(
            book: book,
            list: list,
          );
        });
  }
}

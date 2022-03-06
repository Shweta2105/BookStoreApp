import 'dart:convert';
import 'package:bookstoreapp/model/books.dart';
import 'package:bookstoreapp/utils/bookcard.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:bookstoreapp/utils/customappbar.dart';
import 'package:bookstoreapp/utils/custompopmenu.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Books>> getBooks() async {
    final data =
        await DefaultAssetBundle.of(context).loadString('assets/books.json');
    final response = json.decode(data);
    var res = response as List<dynamic>;
    List<Books> bookList = res.map((e) => Books.fromJson(e)).toList();
    return bookList;
  }

  String? searchString;
  TextEditingController searchcontroller = TextEditingController();
  List<Books> _books = [];

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: displayList(),
    );
  }

  GridView displayList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2 / 3),
        itemCount: _books.length,
        itemBuilder: (BuildContext context, int index) {
          Books book = _books[index];
          return BookCard(book: book);
        });
  }
}

import 'dart:convert';
import 'package:bookstoreapp/providers/book.dart';
import 'package:bookstoreapp/providers/books.dart';
import 'package:bookstoreapp/utils/bookcard.dart';
import 'package:bookstoreapp/utils/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var searchString;
TextEditingController searchcontroller = TextEditingController();
List<Book> _books = [];
List<Book> fliterBooks = [];

class _HomeScreenState extends State<HomeScreen> {
  List list = [];
  // Future<List<Book>> getBooks() async {
  //   final data =
  //       await DefaultAssetBundle.of(context).loadString('assets/books.json');
  //   final response = json.decode(data);
  //   var res = response as List<dynamic>;
  //   List<Book> bookList = res.map((e) => Book.fromJson(e)).toList();
  //   return bookList;
  // }

  void searchMethod(String value) {
    return setState(() {
      searchString = value.toLowerCase();

      fliterBooks = _books
          .where(
              (element) => element.title.toLowerCase().contains(searchString))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    // getBooks().then((value) {
    //   setState(() {
    //     _books = value;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final bookData = Provider.of<Books>(context);
    //getBooks();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          onSearchChange: (value) {
            print("************value in home screen ${value}********");
            searchMethod(value);
          },
        ),
        body: BookGrid(bookData: bookData, list: list)
        // displayList(),
        );
  }
}

class BookGrid extends StatelessWidget {
  const BookGrid({
    Key? key,
    required this.bookData,
    required this.list,
  }) : super(key: key);

  final Books bookData;
  final List list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2 / 3),
        itemCount:
            fliterBooks.isEmpty ? bookData.item.length : fliterBooks.length,
        itemBuilder: (BuildContext context, int index) {
          Book book =
              fliterBooks.isEmpty ? bookData.item[index] : fliterBooks[index];

          return BookCard(
            book: book,
            list: list,
          );
        });
  }
}

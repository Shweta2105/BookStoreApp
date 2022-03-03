import 'dart:convert';
import 'package:bookstoreapp/model/books.dart';
import 'package:bookstoreapp/utils/bookcard.dart';
import 'package:bookstoreapp/utils/constants.dart';
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
      appBar: customAppBar(context),
      body: displayList(),
    );
  }

  customAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: Container(
          margin: appMargin(),
          height: heightL,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 1.0,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: "Search your notes",
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchString = value.toLowerCase();
                      });
                    },
                    controller: searchcontroller,
                  ),
                ),
                const CustomPopMenu()
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView displayList() {
    return ListView.builder(
        itemCount: _books.length,
        itemBuilder: (BuildContext context, int index) {
          Books book = _books[index];
          return BookCard(book: book);
        });
  }
}

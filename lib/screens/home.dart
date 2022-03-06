import 'dart:convert';
import 'package:bookstoreapp/model/books.dart';
import 'package:bookstoreapp/screens/cart.dart';
import 'package:bookstoreapp/utils/bookcard.dart';
import 'package:bookstoreapp/utils/constants.dart';
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
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 128, 10, 2),
        elevation: 1,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Container(
            margin: appMargin(),
            height: heightL,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: white,
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
                        searchMethod(value);
                      },
                      controller: searchcontroller,
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Cart()));
                          },
                          icon: const Icon(Icons.shopping_cart_outlined)),
                      list.length == 0
                          ? Container()
                          : Positioned(
                              top: 2,
                              left: 18,
                              child: Center(
                                child: Text(list.length.toString()),
                              ))
                    ],
                  ),
                  const CustomPopMenu()
                ],
              ),
            ),
          ),
        ),
      ),
      //const CustomAppBar(),
      body: displayList(),
    );
  }

  GridView displayList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2 / 3),
        itemCount: fliterBooks.isEmpty ? _books.length : fliterBooks.length,
        itemBuilder: (BuildContext context, int index) {
          print("---------------${fliterBooks.length}--------------");
          Books book = fliterBooks.isEmpty ? _books[index] : fliterBooks[index];
          print("---------------${_books.length}--------------");
          print('---------------list -------${list.length}--------');
          return BookCard(
            book: book,
            list: list,
          );
        });
  }
}

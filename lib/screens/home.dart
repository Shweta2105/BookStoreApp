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
  Future<List<Books>> getBooks() async {
    final data =
        await DefaultAssetBundle.of(context).loadString('assets/books.json');
    final response = json.decode(data);
    var res = response as List<dynamic>;
    List<Books> bookList = res.map((e) => Books.fromJson(e)).toList();
    return bookList;
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
                        setState(() {
                          searchString = value.toLowerCase();

                          fliterBooks = _books
                              .where((element) => element.title!
                                  .toLowerCase()
                                  .contains(searchString))
                              .toList();
                        });
                        print(
                            "---------------filter ----${fliterBooks}-------------");
                      },
                      controller: searchcontroller,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Cart()));
                      },
                      icon: const Icon(Icons.shopping_cart_outlined)),
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
          return BookCard(book: book);
        });
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(80);
}

class _CustomAppBarState extends State<CustomAppBar> {
  // String? searchString;
  // TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                      setState(() {
                        searchString = value.toLowerCase();

                        fliterBooks = _books
                            .where((element) =>
                                element.title!.contains(searchString))
                            .toList();
                      });
                    },
                    controller: searchcontroller,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Cart()));
                    },
                    icon: const Icon(Icons.shopping_cart_outlined)),
                const CustomPopMenu()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

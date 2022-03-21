import 'package:bookstoreapp/providers/book.dart';
import 'package:bookstoreapp/providers/books.dart';
import 'package:bookstoreapp/utils/appdrawer.dart';
import 'package:bookstoreapp/utils/bookgrid.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:bookstoreapp/utils/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var searchString;
TextEditingController searchcontroller = TextEditingController();
List<Book> _books = [];
List<Book> fliterBooks = [];

class _HomeScreenState extends State<HomeScreen> {
  List list = [];
  var isLoading = false;
  var isInit = true;

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
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Books>(context).fetchBooks().then((_) {
        print('------------in home for list-----------');
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeColor,
      appBar: CustomAppBar(
        onSearchChange: (value) {
          print("************value in home screen ${value}********");
          searchMethod(value);
        },
      ),
      drawer: const AppDrawer(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : BookGrid(),

      // displayList(),
    );
  }
}

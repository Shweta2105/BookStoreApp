import 'dart:convert';

import 'package:bookstoreapp/model/books.dart';
import 'package:bookstoreapp/screens/displaydetails.dart';
import 'package:bookstoreapp/screens/login.dart';
import 'package:bookstoreapp/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want Log Out?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Confirm")),
          ],
        );
      }).then((value) => value ?? false);
}

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

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Container(
            margin: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 12),
            height: 52,
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

                          // filterNotes = noteList
                          //     .where((element) =>
                          //         element.title!.contains(searchString))
                          //     .toList();
                          //noteList = filterNotes;
                        });
                      },
                      controller: searchcontroller,
                    ),
                  ),
                  PopupMenuButton<MenuAction>(
                      offset: const Offset(0.0, 60.0),
                      icon: new Icon(Icons.more_vert_rounded,
                          color: Colors.black),
                      onSelected: (value) async {
                        switch (value) {
                          case MenuAction.logout:
                            final shouldLogOut =
                                await showLogOutDialog(context);
                            if (shouldLogOut) {
                              await AuthService.firebase().logOut();

                              Navigator.pushNamed(context, '/login');
                            }
                            break;
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(child: Text('MyWishList')),
                          PopupMenuItem(child: Text('MyOrders')),
                          PopupMenuItem(
                              child: Text('LogOut'), value: MenuAction.logout),
                        ];
                      })
                ],
              ),
            ),
          ),
        ),
      ),
      body: displayList(),
      //   body: SafeArea(
      //       top: true,
      //       child: SingleChildScrollView(
      //         scrollDirection: Axis.vertical,
      //         child: ListView(
      //           shrinkWrap: true,
      //           children: <Widget>[
      //             Padding(
      //               padding: EdgeInsets.all(25),
      //               child: SizedBox(
      //                 height: 20,
      //                 width: 20,
      //                 child: RichText(
      //                   text: const TextSpan(
      //                     text: 'Hello ',
      //                     style: TextStyle(
      //                       fontStyle: FontStyle.italic,
      //                       fontSize: 20,
      //                       color: Colors.white,
      //                     ),
      //                     children: const <TextSpan>[
      //                       TextSpan(
      //                           text: 'World!!!',
      //                           style: TextStyle(fontWeight: FontWeight.bold)),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             FutureBuilder(
      //                 future: getBooks(),
      //                 builder: (BuildContext context,
      //                     AsyncSnapshot<List<Books>> snapshot) {
      //                   if (snapshot.connectionState == ConnectionState.waiting) {
      //                     print("ConnectionState.waiting state");
      //                     return Center(
      //                       child: CircularProgressIndicator(),
      //                     );
      //                   }
      //                   return ListView.builder(
      //                       shrinkWrap: true,
      //                       itemCount: snapshot.data?.length,
      //                       itemBuilder: (BuildContext context, int index) {
      //                         Books book = snapshot.data![index];
      //                         return BookCard(book: book);
      //                       });
      //                 }),
      //           ],
      //         ),
      //       )),
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

class BookCard extends StatelessWidget {
  Books book;
  BookCard({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DisplayDetails(
                  books: book,
                )));
        // Navigator.pushNamed(context, '/displaydetails');
      },
      child: Container(
        margin: EdgeInsets.all(40),
        height: 200,
        width: 200,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(29),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 33,
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
            ),
            Image.asset(
              book.image!,
              // showData[index]['image'],
              width: 130,
              height: 180,
              fit: BoxFit.cover,
            ),
            Positioned(
                right: 10,
                bottom: 10,
                child: Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_outline_outlined))
                  ],
                )),
            Positioned(
              top: 20,
              left: 150,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  text: book.title,
                  children: [
                    TextSpan(text: '\n\n'),
                    TextSpan(
                        text: book.author,
                        style: TextStyle(fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

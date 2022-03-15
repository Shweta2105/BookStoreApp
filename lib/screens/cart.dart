import 'dart:ui';

import 'package:bookstoreapp/providers/book.dart';
import 'package:bookstoreapp/service/auth/auth_service.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:bookstoreapp/utils/customappbar.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  Book? book;
  Cart({Book? book});

  @override
  State<Cart> createState() => _CartState();
}

var numOfItem = 1;

class _CartState extends State<Cart> {
  List<Book> orderList = [];

  Future<List<Book>> orderedList() async {
    List<Book> bookInCart = await AuthService.firebase().getOrderList();
    orderList.addAll(bookInCart);
    return orderList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderedList();
  }

  @override
  Widget build(BuildContext context) {
    orderedList();
    return Scaffold(
      // appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(border: Border.all(color: black)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text('My cart ()'),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<List<Book>>(
                      future: orderedList(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Book>> snapshot) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: orderList.length,
                            itemBuilder: (BuildContext context, int index) {
                              Book orderedBook = orderList[index];

                              print("${orderedBook.title}");
                              return BooksInCart(
                                orderdBook: orderedBook,
                              );
                            });
                      }),
                  orderButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container orderButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FlatButton(
              color: titleColor, onPressed: () {}, child: Text('Place Order')),
        ],
      ),
    );
  }
}

class BooksInCart extends StatefulWidget {
  Book orderdBook;
  BooksInCart({required this.orderdBook});

  @override
  State<BooksInCart> createState() => _BooksInCartState();
}

class _BooksInCartState extends State<BooksInCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Image.asset(
          widget.orderdBook.image,
          //'assets/images/book_4.jpg',
          // showData[index]['image'],
          width: 130,
          height: 180,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.orderdBook.title),
          Text(widget.orderdBook.author),
          SizedBox(
            height: 10,
          ),
          Text(widget.orderdBook.price),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              IconButton(
                  color: Colors.blueGrey,
                  onPressed: () {
                    if (numOfItem > 1) {
                      setState(() {
                        numOfItem--;
                      });
                    }
                  },
                  icon: Icon(Icons.remove)),
              Text(
                numOfItem.toString().padLeft(2, ''),
                style: TextStyle(color: black),
              ),
              IconButton(
                  color: Colors.blueGrey,
                  onPressed: () {
                    setState(() {
                      numOfItem++;
                    });
                  },
                  icon: Icon(Icons.add)),
            ],
          ),
        ]),
      ],
    ));
  }
}

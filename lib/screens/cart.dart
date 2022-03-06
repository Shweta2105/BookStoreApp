import 'dart:ui';

import 'package:bookstoreapp/model/books.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:bookstoreapp/utils/customappbar.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  Books? book;
  Cart({Books? book});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Books> orderList = [];

  var numOfItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
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
                  ListView.builder(
                      itemCount: orderList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return bookInCart(orderList[index]);
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

  Container bookInCart(Books book) {
    return Container(
        child: Row(
      children: [
        Image.asset(
          'assets/images/book_4.jpg',
          // showData[index]['image'],
          width: 130,
          height: 180,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Book Name'),
          Text('author'),
          SizedBox(
            height: 10,
          ),
          Text('price'),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              IconButton(
                  color: Colors.blueGrey,
                  onPressed: () {
                    if (numOfItem > 0) {
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

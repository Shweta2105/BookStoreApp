import 'package:bookstoreapp/providers/book.dart';
import 'package:bookstoreapp/service/auth/auth_service.dart';
import 'package:bookstoreapp/utils/buttons.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:flutter/material.dart';

class DisplayDetails extends StatelessWidget {
  Book books;
  DisplayDetails({
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                  margin: boxMargin2(),
                  child: Stack(
                    children: <Widget>[
                      bookBox(),
                      bookDescription(),
                      buttonsToCart(books)
                    ],
                  )),
              bookImage()
            ],
          ),
        ));
  }

  Positioned bookBox() {
    return Positioned(
      child: Container(
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
    );
  }

  Positioned bookDescription() {
    return Positioned(
        top: 400,
        left: 100,
        child: Column(
          children: <Widget>[
            Text(
              books.title,
              style:
                  const TextStyle(fontSize: fontM, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              books.author,
              style: const TextStyle(
                fontSize: fontM,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Rs.${books.price} ",
              style: const TextStyle(
                fontSize: fontM,
              ),
            ),
          ],
        ));
  }

  Positioned bookImage() {
    return Positioned(
      top: 50,
      left: 105,
      child: Image.asset(
        books.image,
        // showData[index]['image'],
        width: 200,
        height: 300,
        fit: BoxFit.cover,
      ),
    );
  }

  Positioned buttonsToCart(Book book) {
    return Positioned(
        bottom: 50,
        left: 50,
        child: Row(
          children: <Widget>[
            cartButton(),
            SizedBox(
              width: 20,
            ),
            wishlistButton(book)
          ],
        ));
  }
}

import 'package:bookstoreapp/providers/book.dart';
import 'package:bookstoreapp/providers/books.dart';
import 'package:bookstoreapp/utils/buttons.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayDetails extends StatelessWidget {
  static const String routeName = '/display_details';
  var loadedBook = Book(id: '', image: '', title: '', author: '', price: 0);

  @override
  Widget build(BuildContext context) {
    final bookId = ModalRoute.of(context)?.settings.arguments;
    if (bookId != null) {
      var book = bookId as String;
      loadedBook = Provider.of<Books>(context, listen: false).findById(book);
      print('-------------------------------------');
      print(loadedBook);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(loadedBook.title),
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
                      bookDescription(loadedBook),
                      buttonsToCart(loadedBook)
                    ],
                  )),
              bookImage(loadedBook)
            ],
          ),
        ));
  }

  Positioned bookDescription(Book loadedBook) {
    return Positioned(
        top: 400,
        left: 100,
        child: Column(
          children: <Widget>[
            Text(
              loadedBook.title,
              style:
                  const TextStyle(fontSize: fontM, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              loadedBook.author,
              style: const TextStyle(
                fontSize: fontM,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Rs.${loadedBook.price} ",
              style: const TextStyle(
                fontSize: fontM,
              ),
            ),
          ],
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

  Positioned bookImage(Book loadedBook) {
    return Positioned(
      top: 50,
      left: 105,
      child: Image.network(
        loadedBook.image,
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

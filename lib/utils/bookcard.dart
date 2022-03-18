import 'package:bookstoreapp/providers/book.dart';
import 'package:bookstoreapp/providers/cart.dart';
import 'package:bookstoreapp/screens/cartscreen.dart';
import 'package:bookstoreapp/screens/displaydetails.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookCard extends StatefulWidget {
  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool addToBag = false;

  @override
  Widget build(BuildContext context) {
    final book = Provider.of<Book>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DisplayDetails.routeName, arguments: book.id);
        print('-------------------------------------');
        print(book.id);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(left: 5, right: 5),
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 33,
              color: Colors.blueGrey,
            ),
          ],
        ),
        // width: 100,
        child: Stack(
          children: <Widget>[
            displayBook(book),
            displayBookdata(book),
            Positioned(
                left: 30,
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    addToBag == false
                        ? addToBagButton(cart, book, context)
                        : goToBagButton(context),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  SizedBox addToBagButton(Cart cart, Book book, BuildContext context) {
    return SizedBox(
        width: 100,
        height: 30,
        child: RaisedButton(
          color: titleColor,
          onPressed: () async {
            cart.addItem(book.id!, book.price!, book.title!);
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: const Text(
                'Added to Cart..!!',
                textAlign: TextAlign.center,
              ),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeSingleItem(book.id!);
                  }),
            ));
          },
          child: const Text(
            "ADD TO BAG",
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ));
  }

  Positioned displayBook(Book book) {
    return Positioned(
      left: 30,
      child: Image.network(
        book.image!,

        // showData[index]['image'],
        width: 110,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }

  SizedBox goToBagButton(BuildContext context) {
    return SizedBox(
        width: 100,
        height: 30,
        child: RaisedButton(
          color: titleColor,
          onPressed: () {
            setState(() {
              addToBag = !addToBag;
            });

            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CartScreen()));
          },
          child: const Text(
            "GO TO BAG",
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ));
  }

  Positioned displayBookdata(Book book) {
    return Positioned(
        top: 160,
        left: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title!,
              style:
                  const TextStyle(fontSize: fontS, fontWeight: FontWeight.bold),
            ),
            Text(
              book.author!,
              style: const TextStyle(
                fontSize: fontS,
              ),
            ),
            Text(
              "Rs.${book.price} ",
              style: const TextStyle(
                fontSize: fontS,
              ),
            ),
          ],
        ));
  }
}

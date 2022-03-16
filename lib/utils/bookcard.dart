import 'package:bookstoreapp/providers/book.dart';
import 'package:bookstoreapp/providers/cart.dart';
import 'package:bookstoreapp/screens/cartscreen.dart';
import 'package:bookstoreapp/screens/displaydetails.dart';
import 'package:bookstoreapp/service/auth/auth_service.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookCard extends StatefulWidget {
  List list;
  Book book;
  BookCard({
    required this.list,
    required this.book,
  });

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool addToBag = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DisplayDetails.routeName, arguments: widget.book.id);
        print('-------------------------------------');
        print(widget.book.id);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(left: 5, right: 5),
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
            displayBook(),
            displayBookdata(),
            Positioned(
                left: 30,
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    addToBag == false
                        ? addToBagButton(cart)
                        : goToBagButton(context),
                  ],
                ))
          ],
        ),
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
          child: Text(
            "GO TO BAG",
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ));
  }

  SizedBox addToBagButton(Cart cart) {
    return SizedBox(
        width: 100,
        height: 30,
        child: RaisedButton(
          color: titleColor,
          onPressed: () async {
            cart.addItem(widget.book.id, widget.book.price, widget.book.title);
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Added to Cart..!!',
                textAlign: TextAlign.center,
              ),
              duration: Duration(seconds: 2),
              action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeSingleItem(widget.book.id);
                  }),
            ));
          },
          child: Text(
            "ADD TO BAG",
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ));
  }

  Positioned displayBookdata() {
    return Positioned(
        top: 160,
        left: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.book.title,
              style:
                  const TextStyle(fontSize: fontS, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.book.author,
              style: const TextStyle(
                fontSize: fontS,
              ),
            ),
            Text(
              "Rs.${widget.book.price} ",
              style: const TextStyle(
                fontSize: fontS,
              ),
            ),
          ],
        ));
  }

  Positioned displayBook() {
    return Positioned(
      left: 30,
      child: Image.asset(
        widget.book.image,
        // showData[index]['image'],
        width: 110,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}

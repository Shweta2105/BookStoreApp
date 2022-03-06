import 'package:bookstoreapp/model/books.dart';
import 'package:bookstoreapp/screens/cart.dart';
import 'package:bookstoreapp/screens/displaydetails.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  List list;
  Books book;
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
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DisplayDetails(
                  books: widget.book,
                )));
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
            Positioned(
              left: 30,
              child: Image.asset(
                widget.book.image!,
                // showData[index]['image'],
                width: 110,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                top: 160,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.book.title!,
                      style: const TextStyle(
                          fontSize: fontS, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.book.author!,
                      style: const TextStyle(
                        fontSize: fontS,
                      ),
                    ),
                    Text(
                      "Rs.${widget.book.price!} ",
                      style: const TextStyle(
                        fontSize: fontS,
                      ),
                    ),
                  ],
                )),
            Positioned(
                left: 30,
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    addToBag == false
                        ? SizedBox(
                            width: 100,
                            height: 30,
                            child: RaisedButton(
                              color: titleColor,
                              onPressed: () {
                                setState(() {
                                  widget.list.add(1);
                                  addToBag = !addToBag;
                                });

                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => Cart(
                                //           book: widget.book,
                                //         )));
                              },
                              child: Text(
                                "ADD TO BAG",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ))
                        : SizedBox(
                            width: 100,
                            height: 30,
                            child: RaisedButton(
                              color: titleColor,
                              onPressed: () {
                                setState(() {
                                  addToBag = !addToBag;
                                });

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Cart(
                                          book: widget.book,
                                        )));
                              },
                              child: Text(
                                "GO TO BAG",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            )),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

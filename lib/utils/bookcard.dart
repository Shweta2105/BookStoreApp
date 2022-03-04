import 'package:bookstoreapp/model/books.dart';
import 'package:bookstoreapp/screens/displaydetails.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:flutter/material.dart';

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
                book.image!,
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
                      book.title!,
                      style: const TextStyle(
                          fontSize: fontS, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      book.author!,
                      style: const TextStyle(
                        fontSize: fontS,
                      ),
                    ),
                    Text(
                      "Rs.${book.price!} ",
                      style: const TextStyle(
                        fontSize: fontS,
                      ),
                    ),
                  ],
                )),
            Positioned(
                left: 10,
                bottom: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 80,
                        height: 30,
                        child: RaisedButton(
                          color: titleColor,
                          onPressed: () {},
                          child: Text(
                            "ADD TO BAG",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        )),
                    SizedBox(
                        width: 80,
                        height: 30,
                        child: RaisedButton(
                          onPressed: () {},
                          child: Text(
                            "WishList",
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

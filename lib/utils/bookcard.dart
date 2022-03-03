import 'package:bookstoreapp/model/books.dart';
import 'package:bookstoreapp/screens/displaydetails.dart';
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

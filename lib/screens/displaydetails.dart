import 'package:bookstoreapp/model/books.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:flutter/material.dart';

class DisplayDetails extends StatelessWidget {
  Books books;
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
                      Positioned(
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
                      ),
                      Positioned(
                          top: 400,
                          left: 100,
                          child: Column(
                            children: <Widget>[
                              Text(
                                books.title!,
                                style: const TextStyle(
                                    fontSize: fontM,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                books.author!,
                                style: const TextStyle(
                                  fontSize: fontM,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Rs.${books.price!} ",
                                style: const TextStyle(
                                  fontSize: fontM,
                                ),
                              ),
                            ],
                          )),
                      Positioned(
                          bottom: 50,
                          left: 50,
                          child: Row(
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  'Add to Cart',
                                  style: const TextStyle(
                                    fontSize: fontS,
                                  ),
                                ),
                                color: titleColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Text(
                                        'Add to WishList',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Icon(
                                        Icons.favorite_outline_outlined,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ))
                            ],
                          ))
                    ],
                  )),
              Positioned(
                top: 50,
                left: 105,
                child: Image.asset(
                  books.image!,
                  // showData[index]['image'],
                  width: 200,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ));
  }
}

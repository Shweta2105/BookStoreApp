import 'package:bookstoreapp/screens/login.dart';
import 'package:bookstoreapp/service/auth/auth_service.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoggedin = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/book3.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.dstATop))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Book Store App",
            style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            color: Colors.transparent,
            onPressed: () {
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                Navigator.pushNamed(context, '/homescreen');
              } else {
                Navigator.pushNamed(context, '/login');
              }
            },
            child: Text(
              "Lets get started with reading....",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white54,
                  decoration: TextDecoration.none),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:bookstoreapp/providers/auth.dart';
import 'package:bookstoreapp/screens/authscreen.dart';
import 'package:bookstoreapp/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoggedin = false;
  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<Auth>(context, listen: false);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('assets/images/book3.jpg'),
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
          const SizedBox(
            height: 10,
          ),
          RaisedButton(
            color: Colors.transparent,
            onPressed: () {
              checkLogin(authUser, context);
              // //Navigator.pushNamed(context, '/home');
              // // final user = AuthService.firebase().currentUser;
              // // if (user != null) {
              // // Navigator.pushNamed(context, '/home');
              // //} else {
              // Navigator.pushNamed(context, '/login');
              // //}
            },
            child: const Text(
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

  void checkLogin(Auth authUser, BuildContext context) {
    if (authUser.isAuth) {
      setState(() {
        isLoggedin = true;
      });
      print('login success ');
      print('----------------------------------');
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }
}

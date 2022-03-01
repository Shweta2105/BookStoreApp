import 'package:bookstoreapp/utils/constants.dart';
import 'package:bookstoreapp/utils/userentrytextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();

  bool emailValid = true;
  bool passwordValid = true;
  bool nameValid = true;
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        "assets/images/lib_2.jpg",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Text(
            "Sign in To Us...",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                "BookStoreApp",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.withOpacity(0.8)),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 100,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: UserEntryTextField(
                  obscureText: false,
                  checkValidation: (String value) {
                    nameValid = value.length <= 15;
                  },
                  controller: nameEditingController,
                  labelText: 'Name',
                  isValid: nameValid,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 100,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: UserEntryTextField(
                  obscureText: false,
                  checkValidation: (value) {
                    if (emailRegExp.hasMatch(value)) {
                      emailValid = true;
                    } else {
                      emailValid = false;
                    }
                    setState(() {});
                  },
                  controller: emailEditingController,
                  labelText: 'Email',
                  isValid: emailValid,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 100,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: UserEntryTextField(
                  obscureText: true,
                  checkValidation: (value) {
                    if (passwordRegExp.hasMatch(value)) {
                      passwordValid = true;
                    } else {
                      passwordValid = false;
                    }
                    setState(() {});
                  },
                  controller: passwordEditingController,
                  labelText: 'Password',
                  isValid: passwordValid,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.transparent,
                    child: const Text('Sign In',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    onPressed: () {}
                    //loginUser
                    ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Or',
                style: TextStyle(
                    fontSize: 15, color: Colors.orange.withOpacity(0.8)),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: FlatButton(
                    textColor: Colors.orange.withOpacity(0.8),
                    color: Colors.transparent,
                    child: const Text('Sign Up with Google',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    }
                    //loginUser
                    ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

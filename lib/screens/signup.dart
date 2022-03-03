import 'package:bookstoreapp/service/auth/auth_exception.dart';
import 'package:bookstoreapp/service/auth/auth_service.dart';
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
                height: heightM,
              ),
              Text(
                "BookStoreApp",
                style: TextStyle(
                    fontSize: fontL,
                    fontWeight: FontWeight.bold,
                    color: titleColor),
              ),
              SizedBox(
                height: heightM,
              ),
              Container(
                height: heightXl,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: UserEntryTextField(
                  obscureText: false,
                  controller: nameEditingController,
                  labelText: 'Name',
                ),
              ),
              SizedBox(
                height: heightM,
              ),
              Container(
                height: heightXl,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: UserEntryTextField(
                  obscureText: false,
                  controller: emailEditingController,
                  labelText: 'Email',
                ),
              ),
              SizedBox(
                height: heightM,
              ),
              Container(
                height: heightXl,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: UserEntryTextField(
                  obscureText: true,
                  controller: passwordEditingController,
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                height: heightM,
              ),
              Container(
                height: heightL,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.transparent,
                    child: const Text('Sign In',
                        style: TextStyle(
                          fontSize: fontM,
                        )),
                    onPressed: () async {
                      try {
                        await AuthService.firebase().createUser(
                          email: emailEditingController.text,
                          password: passwordEditingController.text,
                          name: nameEditingController.text,
                        );
                        Navigator.pushNamed(context, '/login');
                      } on WeakPasswordAuthException catch (e) {
                        showErrorDialog(context, 'Weak Password');
                      } on EmailAlreadyInUseAuthException catch (e) {
                        showErrorDialog(
                            context, 'This Email is Already in use. ');
                      } on InvalidEmailAuthException catch (e) {
                        showErrorDialog(context, 'Invalid Email Id');
                      } on GenericAuthException catch (e) {
                        showErrorDialog(context, 'Failed to register');
                      }
                    }
                    //loginUser
                    ),
              ),
              SizedBox(
                height: heightM,
              ),
              Text(
                'Or',
                style: TextStyle(fontSize: fontM, color: titleColor),
              ),
              SizedBox(
                height: heightM,
              ),
              Container(
                height: heightL,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: FlatButton(
                    textColor: titleColor,
                    color: Colors.transparent,
                    child: const Text('Sign Up with Google',
                        style: TextStyle(
                          fontSize: fontM,
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

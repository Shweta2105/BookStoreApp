import 'package:bookstoreapp/service/auth/auth_exception.dart';
import 'package:bookstoreapp/service/auth/auth_service.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:bookstoreapp/utils/userentrytextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  bool emailValid = true;
  bool passwordValid = true;

  @override
  void initState() {
    super.initState();
    emailEditingController;
    passwordEditingController;
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

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
            "Login",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
                  controller: emailEditingController,
                  labelText: 'Email',
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
                  controller: passwordEditingController,
                  labelText: 'Password',
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
                    child: const Text('Login',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    onPressed: () async {
                      try {
                        await AuthService.firebase().logIn(
                          email: emailEditingController.text,
                          password: passwordEditingController.text,
                        );
                        final user = AuthService.firebase().currentUser;
                        if (user != null) {
                          Navigator.of(context)
                              .pushNamed('/home', arguments: (_) => false);
                        }
                      } on UserNotFoundException catch (e) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Text('User not found');
                            });
                      } on WrongPasswordAuthException catch (e) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Text('Wrong Password');
                            });
                      } on GenericAuthException catch (e) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Text('failed to search user.. try again');
                            });
                      }
                    }
                    //loginUser
                    ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Does not have account?',
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
                    child: const Text('Sign in',
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

enum MenuAction { logout }

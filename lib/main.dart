import 'package:bookstoreapp/providers/books.dart';
import 'package:bookstoreapp/providers/cart.dart';
import 'package:bookstoreapp/screens/cartscreen.dart';
import 'package:bookstoreapp/screens/displaydetails.dart';
import 'package:bookstoreapp/screens/home.dart';
import 'package:bookstoreapp/screens/login.dart';
import 'package:bookstoreapp/screens/signup.dart';
import 'package:bookstoreapp/screens/welcomescreen.dart';

import 'package:bookstoreapp/service/auth/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthService.firebase().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Books(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp(
          title: 'Book Store App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
          home: WelcomeScreen(),
          routes: {
            DisplayDetails.routeName: (context) => DisplayDetails(),
            CartScreen.routeName: (context) => CartScreen(),
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
            '/home': (context) => HomeScreen(),
          }),
    );
  }
}

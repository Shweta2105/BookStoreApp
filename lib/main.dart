import 'package:bookstoreapp/providers/auth.dart';
import 'package:bookstoreapp/providers/books.dart';
import 'package:bookstoreapp/providers/cart.dart';
import 'package:bookstoreapp/providers/orders.dart';
import 'package:bookstoreapp/screens/cartscreen.dart';
import 'package:bookstoreapp/screens/displaydetails.dart';
import 'package:bookstoreapp/screens/editbookscreen.dart';
import 'package:bookstoreapp/screens/home.dart';
import 'package:bookstoreapp/screens/authscreen.dart';
import 'package:bookstoreapp/screens/managescreen.dart';
import 'package:bookstoreapp/screens/orderscreen.dart';
import 'package:bookstoreapp/screens/welcomescreen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Books>(
          create: (_) => Books('', '', []),
          update: (ctx, auth, previousBooks) {
            print('-**************at main************');
            print(auth.token);
            print('*****************************');
            print(auth.userId);
            return Books(auth.token ?? "", auth.userId ?? "",
                previousBooks == null ? [] : previousBooks.item);
          },
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders('', '', []),
          update: (ctx, auth, previousOrders) {
            print('-**************at main************');
            print(auth.token);
            print('*****************************');
            print(auth.userId);
            print('-------orders--userId in main......');
            return Orders(auth.token ?? "", auth.userId ?? "",
                previousOrders == null ? [] : previousOrders.orders);
          },
        ),
      ],
      child: MaterialApp(
          title: 'Book Store App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
          home: WelcomeScreen(),
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            DisplayDetails.routeName: (context) => DisplayDetails(),
            CartScreen.routeName: (context) => CartScreen(),
            OrderScreen.routeName: (context) => OrderScreen(),
            ManageScreen.routeName: (context) => ManageScreen(),
            EditBookScreen.routeName: (context) => EditBookScreen(),
            AuthScreen.routeName: (context) => AuthScreen(),
          }),
    );
  }
}

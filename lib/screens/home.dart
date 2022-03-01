import 'package:bookstoreapp/screens/login.dart';
import 'package:bookstoreapp/service/auth/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        "assets/images/lib_1.jpg",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          actions: [
            PopupMenuButton<MenuAction>(
                offset: const Offset(0.0, 60.0),
                icon: new Icon(Icons.more_vert_rounded, color: Colors.black),
                onSelected: (value) async {
                  switch (value) {
                    case MenuAction.logout:
                      final shouldLogOut = await showLogOutDialog(context);
                      if (shouldLogOut) {
                        await AuthService.firebase().logOut();

                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/login', (_) => false);
                      }
                      break;
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        child: Text('LogOut'), value: MenuAction.logout)
                  ];
                })
          ],
        ),
      )
    ]);
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want Log Out?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Confirm")),
          ],
        );
      }).then((value) => value ?? false);
}

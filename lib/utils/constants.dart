import 'package:flutter/material.dart';

enum MenuAction { logout, wishList, orders }

EdgeInsets appMargin() =>
    EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 12);

EdgeInsets boxMargin() => const EdgeInsets.fromLTRB(10, 10, 10, 10);
EdgeInsets boxMargin2() => const EdgeInsets.fromLTRB(20, 20, 20, 20);
EdgeInsets boxMargin3() => const EdgeInsets.all(16.0);

final titleColor = Colors.orange.withOpacity(0.8);
const whiteColor = Colors.white;
const transparent = Colors.transparent;
const blackColor = Colors.black;

final homeColor = Color.fromRGBO(255, 255, 255, 1);
final appbarColor = Color.fromARGB(255, 180, 173, 173);
final appbarRedColor = Color.fromARGB(255, 128, 10, 2);

const fontL = 25.0;
const fontM = 20.0;
const fontS = 15.0;

const heightXXl = 300.0;
const heightXl = 100.0;
const heightL = 50.0;
const heightM = 30.0;
const heightS = 10.0;

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want Log Out?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Confirm")),
          ],
        );
      }).then((value) => value ?? false);
}

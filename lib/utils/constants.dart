import 'package:flutter/material.dart';

enum MenuAction { logout, wishList, orders }

EdgeInsets appMargin() =>
    EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 12);

final titleColor = Colors.orange.withOpacity(0.8);

const fontL = 25.0;
const fontM = 20.0;

const heightXl = 100.0;
const heightL = 50.0;
const heightM = 30.0;

Future<dynamic> showErrorDialog(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (context) {
        return Text(text);
      });
}

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

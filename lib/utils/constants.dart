import 'package:flutter/material.dart';

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

import 'package:flutter/material.dart';

class EditBookScreen extends StatefulWidget {
  const EditBookScreen({Key? key}) : super(key: key);

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
    );
  }
}

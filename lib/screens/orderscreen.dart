import 'package:bookstoreapp/utils/appdrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookstoreapp/providers/orders.dart' show Orders;
import 'package:bookstoreapp/utils/orderitem.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderItem = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orderItem.orders.length,
          itemBuilder: (ctx, index) => OrderItem(orderItem.orders[index])),
    );
  }
}
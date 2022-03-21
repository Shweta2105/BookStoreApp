import 'package:bookstoreapp/utils/appdrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookstoreapp/providers/orders.dart' show Orders;
import 'package:bookstoreapp/utils/orderitem.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    print('inside build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
          builder: (c, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (dataSnapShot.error != null) {
              const Center(
                child: Text('error occured..!!'),
              );
            }
            return Consumer<Orders>(
                builder: (ctx, orderItem, child) => ListView.builder(
                      itemCount: orderItem.orders.length,
                      itemBuilder: (ctx, index) =>
                          OrderItem(orderItem.orders[index]),
                    ));
          }),
    );
  }
}

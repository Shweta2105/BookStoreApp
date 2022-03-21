import 'package:bookstoreapp/providers/cart.dart' show Cart;
import 'package:bookstoreapp/providers/orders.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookstoreapp/utils/cartItem.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final myCart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: boxMargin(),
            child: Padding(
              padding: boxMargin(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Chip(label: Text('\$${myCart.totalAmount}')),
                  OrderButton(myCart: myCart)
                ],
              ),
            ),
          ),
          const SizedBox(
            height: heightS,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: myCart.items.length,
                  itemBuilder: (context, index) => CartItem(
                      myCart.items.values.toList()[index].id,
                      myCart.items.keys.toList()[index],
                      myCart.items.values.toList()[index].price,
                      myCart.items.values.toList()[index].quantity,
                      myCart.items.values.toList()[index].title)))
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.myCart,
  }) : super(key: key);

  final Cart myCart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: widget.myCart.totalAmount <= 0
          ? null
          : () async {
              setState(() {
                isLoading = true;
              });
              Provider.of<Orders>(context, listen: false).addOrders(
                  widget.myCart.items.values.toList(),
                  widget.myCart.totalAmount);
              setState(() {
                isLoading = false;
              });
              widget.myCart.clear();
            },
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              'Order Now',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
    );
  }
}

import 'package:bookstoreapp/screens/cartscreen.dart';
import 'package:bookstoreapp/screens/home.dart';
import 'package:bookstoreapp/utils/appdrawer.dart';
import 'package:bookstoreapp/utils/badge.dart';
import 'package:bookstoreapp/utils/constants.dart';
import 'package:bookstoreapp/providers/cart.dart';
import 'package:bookstoreapp/utils/custompopmenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String) onSearchChange;
  CustomAppBar({Key? key, required this.onSearchChange}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(80);
}

class _CustomAppBarState extends State<CustomAppBar> {
  // String? searchString;
  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 128, 10, 2),
      elevation: 1,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: Container(
          margin: appMargin(),
          height: heightL,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 1.0,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: "Search your notes",
                    ),
                    onChanged: (value) {
                      setState(() {
                        print("---------------${value}--------");
                        widget.onSearchChange(value);
                        //print(onSearchChange.toString());
                      });
                    },
                    controller: searchcontroller,
                  ),
                ),
                Consumer<Cart>(
                  builder: (_, cart, ch) => Badge(
                    child: ch!,
                    value: cart.itemCount.toString(),
                    //cart.itemCount,
                    color: Theme.of(context).accentColor,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                  ),
                ),
                const CustomPopMenu()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

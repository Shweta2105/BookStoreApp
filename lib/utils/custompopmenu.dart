import 'package:bookstoreapp/screens/myorders.dart';
import 'package:bookstoreapp/screens/wishlist.dart';

import 'package:bookstoreapp/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomPopMenu extends StatelessWidget {
  const CustomPopMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
        offset: const Offset(0.0, 60.0),
        icon: const Icon(Icons.more_vert_rounded, color: Colors.black),
        onSelected: (value) async {
          print(value);
          switch (value) {
            case MenuAction.logout:
              final shouldLogOut = await showLogOutDialog(context);
              if (shouldLogOut) {
                //await AuthService.firebase().logOut();

                Navigator.pushNamed(context, '/login');
              }
              break;
            case MenuAction.wishList:
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => WishList()));
              print("-----------wishlist------------");
              break;
            case MenuAction.orders:
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyOrders()));
              break;
          }
        },
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
              child: Text('MyWishList'),
              value: MenuAction.wishList,
            ),
            const PopupMenuItem(
              child: Text('MyOrders'),
              value: MenuAction.orders,
            ),
            const PopupMenuItem(
                child: Text('LogOut'), value: MenuAction.logout),
          ];
        });
  }
}

import 'package:afrobrains_cameroon/provider/product_data.dart';
import 'package:afrobrains_cameroon/screen/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Badge extends StatefulWidget {
  @override
  _BadgeState createState() => _BadgeState();
}

class _BadgeState extends State<Badge> {
  bool notifaction = false;
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);
    productProvider.getCartData();
    // print(productProvider.getcartList.length);
    return productProvider.getcartList.length == 0
        ? IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
          )
        : Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    notifaction = true;
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ),
                  );
                },
                icon: Icon(Icons.notifications_outlined),
              ),
              notifaction == false
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10, right: 5),
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                        child: Text(
                          "${productProvider.getcartList.length}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Container(),
            ],
          );
  }
}

import 'package:afrobrains_cameroon/provider/firebase_data_provider.dart';
import 'package:afrobrains_cameroon/provider/product_data.dart';
import 'package:afrobrains_cameroon/widget/single_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  int value = 0;

  @override
  void initState() {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.getCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    // double shipping = 10;
    double discount = 5;

    int subTotal = productProvider.subTotal();

    int shipping = 10;

    double discountValue = (subTotal * discount) / 100;
    double value = subTotal - discountValue;
    double total = value += shipping;
    if (productProvider.getcartList.isEmpty) {
      setState(() {
        total = 0.0;
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 360,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              leading: Text(
                "37/6 A,Moratuwa, Sri Lanka",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              trailing: Text(
                "⬤",
                style: TextStyle(color: Color(0xff07951f), fontSize: 18),
              ),
            ),
            ListTile(
              leading: Text(
                "Sub Total",
                style: TextStyle(
                  color: Color(0xffb1b1b1),
                ),
              ),
              trailing: Text(
                "\$ $subTotal",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              leading: Text(
                "Discount",
                style: TextStyle(
                  color: Color(0xffb1b1b1),
                ),
              ),
              trailing: Text(
                "5%",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              leading: Text(
                "Shipping",
                style: TextStyle(
                  color: Color(0xffb1b1b1),
                ),
              ),
              trailing: Text(
                "\$10.00",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Text(
                "Total",
                style: TextStyle(
                  color: Color(0xffb1b1b1),
                ),
              ),
              trailing: Text(
                "\$ ${total.toString()}",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            MaterialButton(
                height: 60,
                color: Color(0xff067d45),
                child: Center(
                  child: Text(
                    "BUY",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: productProvider.getcartList.isEmpty
                    ? null
                    : () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => CheckOutPage(),
                        //   ),
                        // );
                      }),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: Text(
              "Checkout",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          Expanded(
            child: productProvider.getcartList.isEmpty
                ? Center(
                    child: Text("No Product"),
                  )
                : ListView.builder(
                    itemCount: productProvider.getcartList.length,
                    itemBuilder: (context, index) {
                      var data = productProvider.cartList[index];
                      return SingleCartItem(
                        productId: data.productId,
                        productImage: data.productImage,
                        // productModel: data.productModel,
                        productName: data.productName,
                        productPrice: data.productPrice,
                        quantity: data.productQuantity!,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

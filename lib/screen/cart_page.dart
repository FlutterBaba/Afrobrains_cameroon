import 'package:afrobrains_cameroon/provider/product_data.dart';
import 'package:afrobrains_cameroon/screen/check_out_page.dart';
import 'package:afrobrains_cameroon/widget/badge.dart';
import 'package:afrobrains_cameroon/widget/single_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    productProvider.getCartData();
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 60,
        child: MaterialButton(
          color: Color(0xff067d45),
          child: Center(
            child: Text(
              "CONTINUE",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          onPressed: productProvider.getcartList.isEmpty
              ? null
              : () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CheckOutPage(),
                    ),
                  );
                },
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          Badge(),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: Text(
              "Cart",
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
                      return productProvider.getcartList.isEmpty
                          ? Center(
                              child: Text(
                              "No Data",
                            ))
                          : SingleCartItem(
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

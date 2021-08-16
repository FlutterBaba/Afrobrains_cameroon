import 'package:afrobrains_cameroon/provider/product_data.dart';
import 'package:afrobrains_cameroon/screen/cart_page.dart';
import 'package:afrobrains_cameroon/widget/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final String productImage;
  final String productName;
  final int productPrice;
  final int productOldPrice;
  final String productId;
  final double productRate;
  DetailPage({
    required this.productRate,
    this.productId = '',
    this.productImage = '',
    this.productName = '',
    this.productOldPrice = 0,
    this.productPrice = 0,
  });
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: MaterialButton(
                color: Color(0xfff4f5f9),
                child: Center(
                  child: Text(
                    "ADD TO CART",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                onPressed: () {
                  productProvider.sendCartData(
                    productId: productId,
                    productImage: productImage,
                    productModel: "productModel",
                    productName: productName,
                    productPrice: productPrice,
                    productQuantity: 1,
                  );

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: MaterialButton(
                color: Color(0xff03971f),
                child: Center(
                  child: Text(
                    "BUY NOW",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [Badge()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                productImage,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              productName,
              style: TextStyle(
                color: Color(0xff292929),
                fontSize: 25,
              ),
            ),
            Row(
              children: [
                Text(
                  "\$ $productPrice",
                  style: TextStyle(
                    color: Color(0xff05961d),
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "$productOldPrice",
                  style: TextStyle(
                    color: Color(0xff292929),
                    decoration: TextDecoration.lineThrough,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        color: Color(0xff05961d),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0)),
                        minWidth: 70,
                        height: 50,
                        child: Center(
                          child: Text(
                            productRate.toString(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        "49 Reviews",
                        style: TextStyle(
                          color: Color(0xff05961d),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
            Text(
              "Description",
              style: TextStyle(
                color: Color(0xff292929),
                fontSize: 20,
              ),
            ),
            Text(
              "A wonderful serenity has token possession\nof my entire soul,like these sweet",
              style: TextStyle(
                color: Color(0xff8a8a8a),
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

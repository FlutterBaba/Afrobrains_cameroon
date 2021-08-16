import 'package:afrobrains_cameroon/provider/product_data.dart';
import 'package:afrobrains_cameroon/widget/cateory_view.dart';
import 'package:afrobrains_cameroon/widget/singleProduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    productProvider.favoriteProduct();
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   // title: Text(
      //   //   'Favorite',
      //   //   style: TextStyle(
      //   //     color: Colors.black,
      //   //   ),
      //   // ),
      //   //  leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      // ),
      body: CategoryView(
        listOfModel: productProvider.favoriteList,
      ),
    );
  }
}

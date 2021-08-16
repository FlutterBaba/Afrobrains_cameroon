import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingleCartItem extends StatefulWidget {
  final String? productImage;
  int? productPrice;
  int quantity = 1;
  final String? productName;
  final String? productId;

  SingleCartItem({
    required this.productId,
    required this.productImage,
    required this.productPrice,
    required this.quantity,
    required this.productName,
  });
  @override
  _SingleCartItemState createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  final String? productModel = "productModel";

  // int updateQuantity = 1;
  @override
  Widget build(BuildContext context) {
    // updateQuantity = widget.quantity;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          //single cart image place
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.network(
                widget.productImage.toString(),
              ),
            ),
          ),

          /// product details place
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.productName!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      // height: 50,
                      // width: 50,
                      decoration: BoxDecoration(
                        color: Color(0xfff6f6f6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            deleteProduct(productId: widget.productId);
                          },
                          child: Icon(Icons.close),
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  productModel!,
                  style: TextStyle(
                    color: Color(0xff9a9ba0),
                  ),
                ),
                Text(
                  "\$ ${widget.productPrice}",
                  style: TextStyle(
                    color: Color(0xff5d9a78),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 40),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xfff6f6f6),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          if (widget.quantity > 1) {
                            setState(() {
                              widget.quantity--;
                              updateProductQuantity(
                                productQuantity: widget.quantity,
                                productId: widget.productId,
                              );
                            });
                          }
                        },
                        child: Icon(
                          Icons.remove,
                        ),
                      ),
                      Text(widget.quantity.toString()),
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.quantity++;
                            print(widget.quantity);
                            updateProductQuantity(
                              productQuantity: widget.quantity,
                              productId: widget.productId,
                            );
                          });
                        },
                        child: Icon(
                          Icons.add,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  updateProductQuantity({
    productId,
    productQuantity,
  }) {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(productId)
        .update({
      "productQuantity": productQuantity,
    });
  }

  deleteProduct({
    productId,
  }) {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(productId)
        .delete();
  }
}

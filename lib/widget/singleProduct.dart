import 'package:afrobrains_cameroon/provider/product_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleProductWidget extends StatefulWidget {
  final String? productImage;
  final String? productName;
  final String? productModel;
  final int? productPrice;
  final int? productOldPrice;
  final String productId;
  final double productRate;
  final String? productCategory;
  // final bool productFavorite;
  final onTap;

  SingleProductWidget({
    // required this.productFavorite,
    required this.productCategory,
    required this.productRate,
    required this.productId,
    required this.onTap,
    this.productImage,
    this.productName,
    this.productModel,
    required this.productPrice,
    required this.productOldPrice,
  });
  @override
  _SingleProductWidgetState createState() => _SingleProductWidgetState();
}

class _SingleProductWidgetState extends State<SingleProductWidget> {
  bool isFave = false;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    FirebaseFirestore.instance
        .collection("favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userFavorite")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      isFave = value.get("favorite");
                    }),
                  }
              }
          },
        );

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 180,
        child: CachedNetworkImage(
          imageUrl: widget.productImage!,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: Center(child: CircularProgressIndicator()),
          ),
          imageBuilder: (context, imageProvider) => Container(
            margin: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.productImage!,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      // focusColor: Colors.transparent,
                      // hoverColor: Colors.transparent,
                      // disabledColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          isFave = !isFave;
                          if (isFave == true) {
                            productProvider.favorite(
                              productCategory: widget.productCategory,
                              productFavorite: true,
                              productId: widget.productId,
                              productImage: widget.productImage,
                              productModel: widget.productModel,
                              productName: widget.productName,
                              productOldPrice: widget.productOldPrice,
                              productPrice: widget.productPrice,
                              productRate: widget.productRate,
                            );
                          } else if (isFave == false) {
                            FirebaseFirestore.instance
                                .collection("favorite")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("userFavorite")
                                .doc(widget.productId)
                                .delete();
                          }
                        });
                      },
                      icon: Icon(
                        isFave ? Icons.favorite : Icons.favorite_border,
                        size: 30,
                        color: Colors.orange[700],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.productName!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.productModel!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(),
                      ),
                      Row(
                        children: [
                          Text(
                            "\$ ${widget.productPrice}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "\$ ${widget.productOldPrice}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

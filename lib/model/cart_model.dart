import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String? productName;
  // final String? productModel;
  final String? productId;
  final int? productPrice;
  final String? productImage;
  final int? productQuantity;

  CartModel({
    this.productImage,
    this.productId,
    this.productName,
    this.productPrice,
    this.productQuantity,
  });
  factory CartModel.fromDocument(QueryDocumentSnapshot doc) {
    return CartModel(
      productId: doc["productId"],
      productImage: doc["productImage"],
      productName: doc["productName"],
      productPrice: doc["productPrice"],
      productQuantity: doc["productQuantity"],
    );
  }
}

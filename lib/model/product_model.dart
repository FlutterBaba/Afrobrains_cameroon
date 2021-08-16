class ProductModel {
  String productName = '';
  String productImage = '';
  int productPrice;
  String productModel = '';
  int productOldPrice;
  String productId = "";
  String productCategory = "";
  double productRate;
  ProductModel({
    required this.productCategory,
    required this.productRate,
    required this.productId,
    required this.productModel,
    required this.productOldPrice,
    required this.productImage,
    required this.productName,
    required this.productPrice,
  });
}

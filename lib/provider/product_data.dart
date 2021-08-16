import 'package:afrobrains_cameroon/model/cart_model.dart';
import 'package:afrobrains_cameroon/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> productList = [];
  List<ProductModel> searchList = [];
  late ProductModel productModel;
  fetchPrduct() async {
    List<ProductModel> newsearchList = [];
    List<ProductModel> newProductList = [];
    QuerySnapshot snapShot =
        await FirebaseFirestore.instance.collection("product").get();
    snapShot.docs.forEach(
      (element) {
        productModel = ProductModel(
          productCategory: element.get("productCategory"),
          productRate: element.get("productRate"),
          productId: element.get("productId"),
          productModel: element.get("productModel"),
          productOldPrice: element.get("productOldPrice"),
          productPrice: element.get("productPrice"),
          productImage: element.get("productImage"),
          productName: element.get("productName"),
        );
        searchList.add(productModel);
        productList.add(productModel);
        newProductList.add(productModel);
        newsearchList.add(productModel);
      },
    );
    searchList = newsearchList;
    productList = newProductList;
    fetchBestSellPrduct();
    notifyListeners();
  }

  List<ProductModel> get getProductProvider => List.from(this.productList);

  List<ProductModel> get getSearchList {
    return searchList;
  }

/////////////////////////Best Sell ///////////////////////

  List<ProductModel> bestSellList = [];
  fetchBestSellPrduct() async {
    List<ProductModel> newBestSellList = [];
    QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection(
          "product",
        )
        .where("productRate", isGreaterThan: 4.0)
        .orderBy(
          "productRate",
          descending: true,
        )
        .get();
    snapShot.docs.forEach(
      (element) {
        productModel = ProductModel(
          productCategory: element.get("productCategory"),
          productRate: element.get("productRate"),
          productId: element.get("productId"),
          productModel: element.get("productModel"),
          productOldPrice: element.get("productOldPrice"),
          productPrice: element.get("productPrice"),
          productImage: element.get("productImage"),
          productName: element.get("productName"),
        );
        bestSellList.add(productModel);
        newBestSellList.add(productModel);
      },
    );
    print(bestSellList);
    bestSellList = newBestSellList;
    notifyListeners();
  }

  List<ProductModel> get getBestSellProvider => List.from(this.bestSellList);

///////////////////////// Catagorys  ///////////////////////

  List<ProductModel> beansCategoriesList = [];
  List<ProductModel> foodCategoriesList = [];

  categories({required categoryName}) async {
    print(categoryName);

    List<ProductModel> newBeansCategoriesList = [];
    List<ProductModel> newFoodCategoriesList = [];

    QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection(
          "product",
        )
        .where("productCategory", isEqualTo: categoryName)
        .orderBy(
          "productRate",
          descending: true,
        )
        .get();
    snapShot.docs.forEach(
      (element) {
        productModel = ProductModel(
          productCategory: element.get("productCategory"),
          productRate: element.get("productRate"),
          productId: element.get("productId"),
          productModel: element.get("productModel"),
          productOldPrice: element.get("productOldPrice"),
          productPrice: element.get("productPrice"),
          productImage: element.get("productImage"),
          productName: element.get("productName"),
        );
        if (categoryName == "beans") {
          beansCategoriesList.add(productModel);
          newBeansCategoriesList.add(productModel);
        } else if (categoryName == "food") {
          foodCategoriesList.add(productModel);
          newFoodCategoriesList.add(productModel);
        }
      },
    );
    if (categoryName == "beans") {
      beansCategoriesList = newBeansCategoriesList;
    } else if (categoryName == "food") {
      foodCategoriesList = newFoodCategoriesList;
    }

    notifyListeners();
  }

  List<ProductModel> get getBeansCategoriesList =>
      List.from(this.beansCategoriesList);
  List<ProductModel> get getFoodCategoriesList =>
      List.from(this.foodCategoriesList);

///////////////////////////   favorite Product    //////////////////////////////////

  void favorite({
    productId,
    productCategory,
    productRate,
    productModel,
    productOldPrice,
    productPrice,
    productImage,
    productFavorite,
    productName,
  }) {
    FirebaseFirestore.instance
        .collection("favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userFavorite")
        .doc(productId)
        .set({
      "productCategory": productCategory,
      "productRate": productRate,
      "productId": productId,
      "favorite": productFavorite,
      "productModel": productModel,
      "productOldPrice": productOldPrice,
      "productPrice": productPrice,
      "productImage": productImage,
      "productName": productName,
    });
  }

//////////////////////  get Favorite  /////////////////////////////////
  List<ProductModel> favoriteList = [];
  favoriteProduct() async {
    List<ProductModel> newFavoriteList = [];
    QuerySnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userFavorite")
        .get();
    documentSnapshot.docs.forEach(
      (element) {
        productModel = ProductModel(
          productCategory: element.get("productCategory"),
          productRate: element.get("productRate"),
          productId: element.get("productId"),
          productModel: element.get("productModel"),
          productOldPrice: element.get("productOldPrice"),
          productPrice: element.get("productPrice"),
          productImage: element.get("productImage"),
          productName: element.get("productName"),
        );
        favoriteList.add(productModel);
        newFavoriteList.add(productModel);
      },
    );
    favoriteList = newFavoriteList;
    notifyListeners();
  }

  List<ProductModel> get getFavoriteList => List.from(this.favoriteList);

/////////////////////  upload firebase to cart data ///////////////////////////////

  sendCartData({
    productId,
    productImage,
    productModel,
    productName,
    productPrice,
    productQuantity,
  }) {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(productId)
        .set({
      "productId": productId,
      "productImage": productImage,
      "productName": productName,
      "productPrice": productPrice,
      "productQuantity": productQuantity,
    });
  }

////////////////////////   get cart Data  //////////////////////////////////

  List<CartModel> cartList = [];
  CartModel? cartModel;
  Future getCartData() async {
    List<CartModel> newCartList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .get();
    querySnapshot.docs.forEach((element) {
      cartModel = CartModel.fromDocument(element);
      notifyListeners();
      newCartList.add(cartModel!);
    });
    cartList = newCartList;
    notifyListeners();
  }

  int subTotal() {
    int total = 0;
    cartList.forEach((element) {
      total += element.productPrice! * element.productQuantity!;
    });
    return total;
  }

  List<CartModel>get getcartList {
    return cartList;
  }

  //////////////////////////////////////////////////////
}

import 'package:afrobrains_cameroon/model/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> foodcategorylist = [];
  List<CategoryModel> beanscategorylist = [];
  late CategoryModel categoryModel;

  fetchAccessoriesPrduct({required collection}) async {
    List<CategoryModel> newFoodcategorylist = [];
    List<CategoryModel> newBeanscategorylist = [];
    DocumentSnapshot snapShot = await FirebaseFirestore.instance
        .collection("categoryProducts")  
        .doc(collection)
        .get();
    categoryModel = CategoryModel(
      productImage: snapShot.get("productImage"),
      productName: snapShot.get("productName"),
    );
    if (collection == "food") {
      foodcategorylist.add(categoryModel);
      newFoodcategorylist.add(categoryModel);
      foodcategorylist = newFoodcategorylist;
    } else if (collection == "beans") {
      beanscategorylist.add(categoryModel);
      newBeanscategorylist.add(categoryModel);
      beanscategorylist = newBeanscategorylist;
    }
    notifyListeners();
  }

  List<CategoryModel> get getFoodCategoryList =>
      List.from(this.foodcategorylist);
  List<CategoryModel> get getBeansCategoryList =>
      List.from(this.beanscategorylist);
}

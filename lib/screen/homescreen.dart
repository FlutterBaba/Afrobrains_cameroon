import 'package:afrobrains_cameroon/model/category_model.dart';
import 'package:afrobrains_cameroon/model/product_model.dart';
import 'package:afrobrains_cameroon/model/user_model.dart';
import 'package:afrobrains_cameroon/provider/category_product.dart';
import 'package:afrobrains_cameroon/provider/firebase_data_provider.dart';
import 'package:afrobrains_cameroon/provider/product_data.dart';
import 'package:afrobrains_cameroon/screen/cart_page.dart';
import 'package:afrobrains_cameroon/screen/details_page.dart';
import 'package:afrobrains_cameroon/screen/login.dart';
import 'package:afrobrains_cameroon/screen/profile.dart';
import 'package:afrobrains_cameroon/widget/badge.dart';
import 'package:afrobrains_cameroon/widget/category_single_product.dart';
import 'package:afrobrains_cameroon/widget/cateory_view.dart';
import 'package:afrobrains_cameroon/widget/singleProduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favorite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModels? userModels;

  FirebaseDataProvider? firebaseDataProvider;

  List<CategoryModel> foodcatagory = [];
  List<CategoryModel> beanscatagory = [];
  List<ProductModel> searchList = [];
  List<ProductModel> beansCategoryList = [];
  List<ProductModel> foodCategoryList = [];
  List<ProductModel> productList = [];

  List<ProductModel> bestSellList = [];

  // List<ProductModel> foodlist = [];
  // List<ProductModel> beanslist = [];

  var screenWidthSize;

  var screenHeightSize;

  searchFuction(query) {
    List<ProductModel> result = searchList.where((element) {
      return element.productName.toUpperCase().contains(query) ||
          element.productName.toLowerCase().contains(query) ||
          element.productName.toUpperCase().contains(query) &&
              element.productName.toLowerCase().contains(query);
    }).toList();
    return result;
  }

  Widget buildlistTile({leading, void Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leading,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              "See all",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black45,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget foodCategoryFunction() {
    return Row(
        children: foodcatagory.map((e) {
      return CategorySingleProduct(
        whenpress: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CategoryView(
                listOfModel: foodCategoryList,
              ),
            ),
          ),
        },
        image: e.productImage,
        name: e.productName,
      );
    }).toList());
  }

  Widget beansCategoryFunction() {
    return Row(
        children: beanscatagory.map((e) {
      return CategorySingleProduct(
        whenpress: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CategoryView(
                listOfModel: beansCategoryList,
              ),
            ),
          ),
        },
        image: e.productImage,
        name: e.productName,
      );
    }).toList());
  }

  Widget buildSingleCategoryListView() {
    return Container(
      height: 140,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            foodCategoryFunction(),
            beansCategoryFunction(),
          ],
        ),
      ),
    );
  }

  Widget buildProductListView({
    model,
  }) {
    return Container(
      height: 240,
      child: ListView.builder(
        itemCount: model.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var storeData = model[index];
          return SingleProductWidget(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    productRate: storeData.productRate,
                    productId: storeData.productId,
                    productImage: storeData.productImage,
                    productName: storeData.productName,
                    productOldPrice: storeData.productOldPrice,
                    productPrice: storeData.productPrice,
                  ),
                ),
              );
            },
            productRate: storeData.productRate,
            productCategory: storeData.productCategory,
            productId: storeData.productId,
            productImage: storeData.productImage,
            productName: storeData.productName,
            productOldPrice: storeData.productOldPrice,
            productPrice: storeData.productPrice,
            productModel: storeData.productModel,
          );
        },
      ),
    );
  }

  Widget buildSearch() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: screenHeightSize * 0.1 - 15,
            //60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Search Your Product',
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool safe = false;
  AppBar buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Badge(),
        IconButton(
          onPressed: () {
            setState(() {
              safe = !safe;
            });
          },
          icon: safe == false
              ? Icon(
                  Icons.shield_outlined,
                  color: Colors.black,
                )
              : Icon(
                  Icons.shield,
                  color: Colors.grey,
                ),
        ),
      ],
    );
  }

  Drawer buildDrawer({userModels}) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              userModels!.fullName,
            ),
            accountEmail: Text(
              userModels!.email,
            ),
            currentAccountPicture: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage("images/non_profile.jpg"),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    userModels: userModels,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_rounded),
            title: Text('My Cart'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorite'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Favorite(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket_sharp),
            title: Text('My Orders'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_sharp),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String querys = '';

  @override
  void initState() {
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    productProvider.fetchPrduct();

    productProvider.categories(categoryName: "beans");
    productProvider.categories(categoryName: "food");

    categoryProvider.fetchAccessoriesPrduct(collection: "food");
    categoryProvider.fetchAccessoriesPrduct(collection: "beans");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    firebaseDataProvider = Provider.of<FirebaseDataProvider>(context);
    firebaseDataProvider!.getUserData();
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);

    productList = productProvider.getProductProvider;

    bestSellList = productProvider.getBestSellProvider;

    foodcatagory = categoryProvider.getFoodCategoryList;

    beanscatagory = categoryProvider.getBeansCategoryList;

    searchList = productProvider.getSearchList;

    beansCategoryList = productProvider.getBeansCategoriesList;
    foodCategoryList = productProvider.getFoodCategoriesList;

    List<ProductModel> seachresult = searchFuction(querys);

    userModels = firebaseDataProvider!.currentUserModel;

    screenHeightSize = MediaQuery.of(context).size.height;
    screenWidthSize = MediaQuery.of(context).size.width;

    // categoryProvider.foodCategory(collection: "food");
    // categoryProvider.foodCategory(collection: "beans");

    // foodlist = categoryProvider.getFoodList;
    // beanslist = categoryProvider.getBeansList;

    return Scaffold(
      appBar: buildAppBar(),
      drawer: userModels == null
          ? CircularProgressIndicator()
          : buildDrawer(
              userModels: userModels,
            ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height: screenHeightSize * 0.1 - 15,
                  //60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Search Your Product',
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.search,
                              size: 30,
                            ),
                          ),
                        ),
                        onChanged: (query) {
                          setState(() {
                            querys = query;
                          });
                        }),
                  ),
                ),
              ],
            ),
          ),
          // buildSearch(),
          querys == ''
              ? Column(
                  children: [
                    SizedBox(height: screenHeightSize * 0.1 - 30),
                    buildlistTile(
                      leading: "Categories",
                      onTap: () {
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(
                        //     builder: (context) => CategoryGridview(
                        //       categoriesList: beansCategoryList,
                        //       listOfModel: beanscatagory,
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                    buildSingleCategoryListView(),
                    SizedBox(height: screenHeightSize * 0.1 - 40),
                    buildlistTile(
                      leading: "Product",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (cotnext) => CategoryView(
                              listOfModel: productList,
                            ),
                          ),
                        );
                      },
                    ),
                    buildProductListView(model: productList),
                    buildlistTile(
                      leading: "Best Sell",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (cotnext) => CategoryView(
                              listOfModel: bestSellList,
                            ),
                          ),
                        );
                      },
                    ),
                    buildProductListView(model: bestSellList),
                  ],
                )
              : seachresult.isEmpty
                  ? Center(
                      child: Text("NO Item"),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: seachresult.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemBuilder: (contec, index) {
                        var storeData = seachresult[index];
                        return SingleProductWidget(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  productRate: storeData.productRate,
                                  productId: storeData.productId,
                                  productImage: storeData.productImage,
                                  productName: storeData.productName,
                                  productOldPrice: storeData.productOldPrice,
                                  productPrice: storeData.productPrice,
                                ),
                              ),
                            );
                          },
                          productRate: storeData.productRate,
                          productCategory: storeData.productCategory,
                          productId: storeData.productId,
                          productImage: storeData.productImage,
                          productName: storeData.productName,
                          productOldPrice: storeData.productOldPrice,
                          productPrice: storeData.productPrice,
                          productModel: storeData.productModel,
                        );
                      },
                    ),
        ],
      ),
    );
  }
}

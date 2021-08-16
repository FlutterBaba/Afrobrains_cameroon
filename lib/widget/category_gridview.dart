// import 'package:afrobrains_cameroon/model/category_model.dart';
// import 'package:afrobrains_cameroon/model/product_model.dart';
// import 'package:afrobrains_cameroon/screen/homescreen.dart';
// import 'package:afrobrains_cameroon/widget/category_single_product.dart';
// import 'package:afrobrains_cameroon/widget/cateory_view.dart';
// import 'package:flutter/material.dart';

// class CategoryGridview extends StatefulWidget {
//   final List<CategoryModel> listOfModel;

//   final List<ProductModel> categoriesList;
//   CategoryGridview({
//     required this.categoriesList,
//     required this.listOfModel,
//   });

//   @override
//   _CategoryGridviewState createState() => _CategoryGridviewState();
// }

// searchFuction(query, searchList) {
//   List<CategoryModel> result = searchList.where((element) {
//     return element.productName.toUpperCase().contains(query) ||
//         element.productName.toLowerCase().contains(query) ||
//         element.productName.toUpperCase().contains(query) &&
//             element.productName.toLowerCase().contains(query);
//   }).toList();
//   return result;
// }

// class _CategoryGridviewState extends State<CategoryGridview> {
//   String querys = "";
//   @override
//   Widget build(BuildContext context) {
//     List<CategoryModel> seachresult = searchFuction(querys, widget.listOfModel);

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => HomePage(),
//               ),
//             );
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 Container(
//                   //   height: screenHeightSize * 0.1 - 15,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(7),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.4),
//                         spreadRadius: 2,
//                         blurRadius: 7,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: TextFormField(
//                         decoration: InputDecoration(
//                           fillColor: Colors.white,
//                           filled: true,
//                           border:
//                               OutlineInputBorder(borderSide: BorderSide.none),
//                           hintText: 'Search Your Product',
//                           icon: Padding(
//                             padding: const EdgeInsets.only(left: 8.0),
//                             child: Icon(
//                               Icons.search,
//                               size: 30,
//                             ),
//                           ),
//                         ),
//                         onChanged: (query) {
//                           setState(() {
//                             querys = query;
//                           });
//                         }),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           querys == ""
//               ? Container(
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     itemCount: widget.listOfModel.length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 5.0,
//                       mainAxisSpacing: 5.0,
//                     ),
//                     itemBuilder: (contec, index) {
//                       var storeData = widget.listOfModel[index];
//                       return CategorySingleProduct(
//                         whenpress: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => CategoryView(
//                                 listOfModel: widget.categoriesList,
//                               ),
//                             ),
//                           );
//                         },
//                         image: storeData.productImage,
//                         name: storeData.productName,
//                       );
//                     },
//                   ),
//                 )
//               : seachresult.isEmpty
//                   ? Center(
//                       child: Text("NO Item"),
//                     )
//                   : GridView.builder(
//                       shrinkWrap: true,
//                       itemCount: seachresult.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 5.0,
//                         mainAxisSpacing: 5.0,
//                       ),
//                       itemBuilder: (contec, index) {
//                         var storeData = seachresult[index];
//                         return CategorySingleProduct(
//                           whenpress: () {},
//                           image: storeData.productImage,
//                           name: storeData.productName,
//                           // onTap: () {
//                           //   Navigator.of(context).push(
//                           //     MaterialPageRoute(
//                           //       builder: (context) => DetailPage(
//                           //         productRate: storeData.productRate,
//                           //         productId: storeData.productId,
//                           //         productImage: storeData.productImage,
//                           //         productName: storeData.productName,
//                           //         productOldPrice: storeData.productOldPrice,
//                           //         productPrice: storeData.productPrice,
//                           //       ),
//                           //     ),
//                           //   );
//                           // },
//                         );
//                       },
//                     ),
//         ],
//       ),
//     );
//   }
// }

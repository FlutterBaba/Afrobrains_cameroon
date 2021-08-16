import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategorySingleProduct extends StatefulWidget {
  final String image;
  final String name;
  final whenpress;

  CategorySingleProduct({
    required this.whenpress,
    required this.image,
    this.name = '',
  });

  @override
  _CategorySingleProductState createState() => _CategorySingleProductState();
}

class _CategorySingleProductState extends State<CategorySingleProduct> {
  double? screenHeightSize;

  double? screenWidthSize;

  @override
  Widget build(BuildContext context) {
    screenHeightSize = MediaQuery.of(context).size.height;
    screenWidthSize = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.whenpress,
      child: Container(
        height: screenHeightSize! * 0.2 - 50,
        width: screenWidthSize! * 0.4 + 10,
        margin: EdgeInsets.all(10),
        child: CachedNetworkImage(
          imageUrl: widget.image,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: Center(child: CircularProgressIndicator()),
          ),
          imageBuilder: (context, imageProvider) => Container(
            // 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
            //   child: Center(
            child: Center(
              child: Text(
                widget.name,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

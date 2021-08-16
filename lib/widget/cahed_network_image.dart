import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cachedNetworkImage(String imageUrl) {
  // print(image);
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: BoxFit.cover,
    placeholder: (context, url) => Center(
      child: CircularProgressIndicator(),
    ),
    errorWidget: (context, url, error) => Icon(
      Icons.error,
    ),
  );
}

import 'package:flutter/material.dart';

Widget showImage(
    bool imageExist, String imageUrl, double heigth, double width) {
  if (imageExist == true) {
    return Container(
      height: heigth,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image:
            DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
      ),
    );
  } else {
    return Container(
      height: heigth,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: const DecorationImage(
            image: AssetImage('images/no_image.png'), fit: BoxFit.cover),
      ),
    );
  }
}

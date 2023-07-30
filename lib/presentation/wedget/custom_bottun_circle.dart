import 'package:flutter/material.dart';

import 'text_style.dart';

class CustomButtonCircle extends StatelessWidget {
  String assetName;
  final VoidCallback onPressed;

  CustomButtonCircle({
    Key? key,
    this.assetName = '',
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(assetName), fit: BoxFit.contain),
        ),
      ),
    );
  }
}

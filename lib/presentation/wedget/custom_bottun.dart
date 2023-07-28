import 'package:flutter/material.dart';

import 'text_style.dart';

class CustomButton extends StatelessWidget {
  double textSize;
  double width;
  double height;
  final String text;
  final Color mainColor;
  final Color shadowColor;
  final VoidCallback onPressed;

  CustomButton({Key? key,
    this.textSize = 16,
    this.width = 100,
    this.height = 100,
    required this.text,
    required this.mainColor,
    required this.shadowColor,
    required this.onPressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          // border: Border.all(color: Colors.white, width: 0.2),
          color: mainColor,
          boxShadow:  [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(0, 0),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        width: width,
        height: height,
        child: Center(
          child: BoldText(size:textSize, text: text, color: Colors.black),
        ),
      ),
    );
  }
}
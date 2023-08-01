import 'package:flutter/material.dart';

import 'text_style.dart';

class CustomButtonGradation extends StatelessWidget {
  double textSize;
  double width;
  double height;
  final String text;
  final textColor;
  final Color mainColor1;
  final Color mainColor2;
  final Color borderColor1;
  final Color borderColor2;
  final VoidCallback onPressed;

  CustomButtonGradation({Key? key,
    this.textSize = 16,
    this.width = 100,
    this.height = 100,
    this.textColor = Colors.black,
    required this.text,
    required this.mainColor1,
    required this.mainColor2,
    required this.borderColor1,
    required this.borderColor2,
    required this.onPressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width+4,
        height: height+4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.0),
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              borderColor1,
              borderColor2,
            ],
          ),
        ),
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                mainColor1,
                mainColor2,
              ],
            ),
              borderRadius: BorderRadius.circular(10.0),
              // border: Border.all(color: Colors.white, width: 0.2),
            ),
            width: width,
            height: height,
            child: Center(
              child: BoldText(size:textSize, text: text, color: textColor),
            ),
          ),
      ),
    );
  }
}
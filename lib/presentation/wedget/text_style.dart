import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalText extends StatelessWidget {
  double size;
  int? maxLines;
  final String text;
  final Color color;
  NormalText({Key? key,
    this.maxLines,
    this.size = 10,
    required this.text,
    required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.zenKakuGothicNew(
        textStyle: TextStyle(
          // height: 1.0,
          // letterSpacing: -2.0,
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w500
        ),
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class BoldText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  BoldText({Key? key,
    this.size = 10,
    required this.text,
    required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.zenMaruGothic(
        textStyle: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w600
        )
      )
    );
  }
}

class TitleText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  TitleText({Key? key,
    this.size = 10,
    required this.text,
    required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.russoOne(
        textStyle: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w300
        )
      )
    );
  }
}
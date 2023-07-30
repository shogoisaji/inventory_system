import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_various/presentation/wedget/custom_bottun.dart';
import 'package:go_router/go_router.dart';

import 'text_style.dart';
import 'image_download.dart';

class ListInner extends StatelessWidget {
  ListInner({Key? key, required this.indexNumber, required this.stockType})
      : super(key: key);

  final int indexNumber;
  final int stockType;

  Future<String> loadImage() async {
    final ref = FirebaseStorage.instance.ref('images').child('bolt1.png');
    final url = await ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final productName = '';
    final productVolume = 0;
    return Container(
      width: 400,
      height: 90,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 235, 235, 235),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 0, 0, 72).withOpacity(0.3),
            offset: const Offset(2, 2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          const ImageDownload(),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 9,
              ),
              Expanded(
                child: SizedBox(
                  width: 150,
                  child: NormalText(
                    text: 'No.$indexNumber Item description:この商品についての説明になります。',
                    size: 14,
                    color: Colors.black,
                    maxLines: 2,
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: Color.fromARGB(255, 209, 209, 209),
                ),
                child: Stack(children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 45,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Color.fromARGB(255, 135, 135, 135),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: NormalText(
                        text: '総数',
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 70.0),
                    alignment: Alignment.centerLeft,
                    child: NormalText(
                      text: '100',
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          CustomButton(
            text: '詳細',
            mainColor: Color.fromARGB(255, 174, 217, 224),
            shadowColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
            onPressed: () => context.go('/shipping'),
            width: 60,
            height: 70,
            textSize: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          CustomButton(
            text: '出庫',
            mainColor: const Color.fromARGB(255, 255, 166, 158),
            shadowColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
            onPressed: () => context.go('/shipping'),
            width: 60,
            height: 70,
            textSize: 20,
          ),
        ],
      ),
    );
  }
}

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ListInner extends StatelessWidget {
  ListInner({Key? key, required this.indexNumber}) : super(key: key);

  final int indexNumber;

  Future<String> loadImage() async {
    final ref = FirebaseStorage.instance.ref('images').child('bolt1.png');
    final url = await ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: loadImage(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                snapshot.data!,
                width: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 3.0),
                      child: Text('商品名'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text('Item $indexNumber'),
                    ),
                  ],
                ),
              ),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text('登録日'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text('2023.7.25'),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}

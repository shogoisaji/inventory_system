import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageDownload extends StatelessWidget {
  const ImageDownload({Key? key}) : super(key: key);


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
          // return Container(
          //   child: Image.network(
          //     snapshot.data!,
          //     width: 50,
          //   ),
          return Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage('images/no_image.png'),
                fit: BoxFit.cover
              ),
            ),
            margin: const EdgeInsets.all(5),
          );
        }
      }
    );
  }
}
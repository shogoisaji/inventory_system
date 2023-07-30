import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageDownload extends StatelessWidget {
  final String? imageUrl;
  final String nullUrl =
      'https://firebasestorage.googleapis.com/v0/b/inventory-system-6bc22.appspot.com/o/images%2FNoImage.png?alt=media&token=95a23072-296e-4380-abd7-6dcb80ba647b';
  const ImageDownload({Key? key, this.imageUrl}) : super(key: key);

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
            return Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: NetworkImage(imageUrl ?? nullUrl),
                    // ) : const AssetImage('images/no_image.png'),
                    fit: BoxFit.cover),
              ),
            );
          }
        });
  }
}

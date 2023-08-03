import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../application/state/state.dart';
import '../../presentation/wedget/date_get.dart';

class FirebaseService {
  final db = FirebaseFirestore.instance;
  String currentDate = getCurrentDate();

  Future<int> incrementCounter() async {
    DocumentReference counterRef = db.collection('settings').doc('settings');
    return db.runTransaction((transaction) async {
      DocumentSnapshot counterSnapshot = await transaction.get(counterRef);
      if (!counterSnapshot.exists) {
        transaction.set(counterRef, {'currentNumber': 1});
        return 1;
      } else {
        Map<String, dynamic>? data =
            counterSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          int updatedCounter = data['currentNumber'] + 1;
          transaction.update(counterRef, {'currentNumber': updatedCounter});
          return updatedCounter;
        } else {
          throw Exception("Invalid data");
        }
      }
    });
  }

// Firestoreにデータを保存する関数
  Future<void> upLoad(String productName, String productType, int productVolume,
      String userName, File? imageFile, String? fileName) async {
    final imageUrl = "";
    print(imageFile != null ? "exist" : "null");
    int nextId = await incrementCounter();
    if (imageFile != null && fileName != null) {
      final imageUrl =
          await uploadImage(imageFile, nextId.toString() + fileName);
      print(imageFile);

      await FirebaseFirestore.instance
          .collection('items')
          .doc('product$nextId')
          .set({
        'productName': productName,
        'productId': nextId,
        'productType': productType,
        'productVolume': productVolume,
        'imageUrl': imageUrl,
        'timeStamp': currentDate,
        'finalExporterDate': " -",
        'finalExporterPerson': " -",
        'finalInventoryDate': " -",
        'finalInventoryPerson': " -",
      });
    }
  }

  // Cloud Storageに画像をアップロードする関数
  Future<String> uploadImage(File imageFile, String fileName) async {
    // pathはStorage内でのファイルの位置を指定します（例: 'images/myImage.jpg'）
    Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
    // Reference ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = ref.putFile(imageFile);

    // アップロードが完了するのを待つ
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    // ダウンロードURLを取得
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<File?> pickImage() async {
    // Let user pick image from gallery
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    // Check if the image is picked
    if (pickedFile != null) {
      print(pickedFile.path);
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

  Future<DocumentSnapshot> getDocument(
    String collectionName,
    String documentId,
  ) async {
    return await db.collection(collectionName).doc(documentId).get();
  }

  Future<void> valumeIncrement(String product, int incrementValue) async {
    final docRef = FirebaseFirestore.instance.collection('items').doc(product);

    FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot doc = await tx.get(docRef);

      if (doc.exists) {
        int currentValue = doc.get('productValue');
        tx.update(docRef, {'productValue': currentValue + incrementValue});
      }
    });
  }
}

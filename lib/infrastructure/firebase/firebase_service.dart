import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../presentation/wedget/date_get.dart';

class FirebaseService {
  final db = FirebaseFirestore.instance;
  String currentDate = getCurrentDate();

// firestoreデータ取得
  Future<String?> fetchData(String docName, String valueName) async {
    final docRef = db.collection('items').doc(docName);
    await db.runTransaction((Transaction tx) async {
      DocumentSnapshot doc = await tx.get(docRef);
      if (doc.exists) {
        return doc.get(valueName);
      }
    });
    return "0";
  }

// productId連番
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
    }

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
        })
        .then((void value) {})
        .catchError((error) {
          print("Failed to upload data: $error");
        });
  }

// FireStoreのデータを削除する
  Future<String> deleteData(String doc) async {
    String deleteComment;
    try {
      await FirebaseFirestore.instance.collection('items').doc(doc).delete();
      print("'$doc'を削除しました");
      return 'success';
    } catch (error) {
      print("Error: $error");
      return 'error';
    }
  }

// Cloud Storageに画像をアップロードする関数
  Future<String> uploadImage(File imageFile, String fileName) async {
    Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);

    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

// ImagePickerを使って画像選択
  Future<File?> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print(pickedFile.path);
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

// incrementVolume
  Future<void> incrementVolume(
      String docName, String username, int incrementValue) async {
    final docRef = db.collection('items').doc(docName);
    await db.runTransaction((Transaction tx) async {
      DocumentSnapshot doc = await tx.get(docRef);
      if (doc.exists) {
        int currentValue = doc.get('productVolume');
        tx.update(
          docRef,
          {
            'productVolume': currentValue + incrementValue,
            'finalInventoryPerson': username,
            'finalInventoryDate': currentDate,
          },
        );
      }
    });
  }

  // decrementVolume
  Future<void> decrementVolume(
      String docName, String username, int decrementValue) async {
    final docRef = db.collection('items').doc(docName);
    await db.runTransaction((Transaction tx) async {
      DocumentSnapshot doc = await tx.get(docRef);
      if (doc.exists) {
        int currentValue = doc.get('productVolume');
        tx.update(
          docRef,
          {
            'productVolume': currentValue - decrementValue,
            'finalInventoryPerson': username,
            'finalInventoryDate': currentDate,
          },
        );
      }
    });
  }
}

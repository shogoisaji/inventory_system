import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../presentation/pages/warehousing_page.dart';
import '../../presentation/wedget/date_get.dart';

class FireStoreService {
  final db = FirebaseFirestore.instance;

  String currentDate = getCurrentDate();
  /// サインイン
  Future<void> upLoad(String productName, String productId, String productType, String productVolume) async {
    await db
        .collection('items')
        .doc('product')
        .set({
          'productName': productName,
          'productId': productId,
          'productType': productType,
          'productVolume' : productVolume,
          'timeStamp': currentDate,
        }); 
  }

}

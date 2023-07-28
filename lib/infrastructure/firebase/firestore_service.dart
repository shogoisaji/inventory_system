import 'package:cloud_firestore/cloud_firestore.dart';

import '../../presentation/wedget/date_get.dart';

class FireStoreService {
  final db = FirebaseFirestore.instance;

  String currentDate = getCurrentDate();
  Future<void> upLoad(String productName, String productId, String productType, String productVolume) async {
    int? nextId = int.tryParse(getNextId());
    await db
        .collection('items')
        .doc('product$nextId')
        .set({
          'productName': productName,
          'productType': productType,
          'productId': getNextId(),
          'productVolume' : int.tryParse(productVolume),
          'timeStamp': currentDate,
        }); // imageトークンを入れるよ良い
  }

Future<String> getNextId() async {
  QuerySnapshot snapshot = await db
      .collection('items')
      .orderBy('productId', descending: true) // 'id'フィールドで降順ソート
      .limit(1) // 最後の1件だけ取得
      .get();

  if (snapshot.docs.isEmpty) {
    // コレクションが空の場合、最初のIDを"1"とします
    return "1";
  } else {
    // 最後のドキュメントのIDを取得し、1加えて文字列に戻します
    int lastId = int.parse(snapshot.docs.first.data()!['productId']);
    return (lastId + 1).toString();
  }
}


}
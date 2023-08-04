import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../infrastructure/firebase/firebase_service.dart';

class DeleteDialog extends StatelessWidget {
  final String doc = "";

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();

    return FutureBuilder(
      future: service.deleteData(doc), // 非同期の処理を行うFutureを指定します
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // データがまだ来ていないときの表示（ローディングインジケータ等）
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // エラーが起きたときの表示
        } else {
          return AlertDialog(
            title: Text(snapshot.data),
            content: Text("deleteComment"),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.go('/stock');
                },
              ),
            ],
          );
        }
      },
    );
  }
}

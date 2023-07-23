import 'package:flutter/material.dart';

class StockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('在庫'),
      ),
      body: Center(
        child: Text('This is the Profile Screen'),
      ),
    );
  }
}

// class ShowDb extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(centerTitle: true, title: Text('在庫'), actions: [
//           Center(
//             child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Row(children: [
//                   Icon(Icons.account_circle),
//                   Text("login_name")
//                 ])),
//           )
//         ]),
//       ),
//     );
//   }
// }

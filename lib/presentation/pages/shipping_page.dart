import 'package:flutter/material.dart';

import '../wedget/text_input.dart';


class ShippingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('出庫'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(children: [
              Icon(Icons.account_circle),
              Text("login_name")
              ]
              )
            ),
          )
        ]
      ),
      body: Center(
        child: Column(
          children: [
            TextInput(),
            TextInput(),
            TextInput(),
          ],)
      ),
    );
  }
}
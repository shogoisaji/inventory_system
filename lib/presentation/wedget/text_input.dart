import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {

TextEditingController _controller = TextEditingController();

@override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your name',
          )
        ),
      // margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.fromLTRB(200.0, 30.0, 200.0, 30.0),
    );
  }

}
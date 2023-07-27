import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {

TextEditingController _controller = TextEditingController();

@override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 30.0),
      child: TextField(
        controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your name',
          )
        ),
    );
  }

}
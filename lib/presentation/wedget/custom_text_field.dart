import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String label;
  void Function(String text) onChangefunc;
  bool isPassword;

  CustomTextField({
    required this.label,
    required this.onChangefunc,
    required this.isPassword,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Container(
          child: TextField(
            onChanged: (newText) {
              onChangefunc(newText);
            },
            obscureText: isPassword ? true : false,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          padding: EdgeInsets.all(10)),
    );
  }
}

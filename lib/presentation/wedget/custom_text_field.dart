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
          padding: const EdgeInsets.all(10),
          child: TextField(
            onChanged: (newText) {
              onChangefunc(newText);
            },
            obscureText: isPassword ? true : false,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: label,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          )),
    );
  }
}

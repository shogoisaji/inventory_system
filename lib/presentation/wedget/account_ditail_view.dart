import 'package:flutter/material.dart';

class AccountDetailView extends StatelessWidget {
  final String typeText;
  final String textContent;

  AccountDetailView({
    Key? key,
    required this.typeText,
    required this.textContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 300,
        alignment: Alignment.bottomLeft,
        child: Text(typeText,
            style: const TextStyle(
              color: Colors.blueGrey,
            )),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: Colors.blueGrey.withOpacity(0.3),
        ),
        width: 300,
        height: 40,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(textContent, style: const TextStyle(fontSize: 18.0)),
      ),
    ]);
  }
}

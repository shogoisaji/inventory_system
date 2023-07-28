import 'package:flutter/material.dart';

const  List<String> list = <String>['部品', '文房具', '機器', '消耗品', '梱包材'];
var selectedValue = "部品";

class DropdownCategory extends StatelessWidget {
  const DropdownCategory({super.key});
  
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: (String? value) {
        selectedValue = value!;
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
          ),
        );
      }).toList(),
    );
  }

}
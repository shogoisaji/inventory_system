import 'package:flutter/material.dart';

const  List<String> list = <String>['金属製品', '化学製品', 'プラスチック製品', 'ゴム製品', '電子部品', '工具', '安全用具', 'メンテナンス用品', 'オフィス用品', '梱包材'];
var selectedValue = "金属製品";

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
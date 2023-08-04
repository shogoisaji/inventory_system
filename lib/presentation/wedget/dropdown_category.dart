import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_various/application/state/state.dart';

const List<String> list = <String>['部品', '文房具', '機器', '消耗品', '梱包材'];
var selectedType = "部品";

class DropdownCategory extends ConsumerWidget {
  const DropdownCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    selectedType = ref.watch(productTypeProvider);
    return DropdownButton<String>(
      value: selectedType,
      onChanged: (String? value) {
        ref.read(productTypeProvider.notifier).state = value!;
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

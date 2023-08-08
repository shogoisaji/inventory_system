import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/state/state.dart';
import '../../domain/types/product.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productSnapshot = ref.watch(productSnapshotProvider);
    print(ref.watch(productSnapshotProvider) != null);

    final product = Product(
      // productId: productSnapshot?['productId'],
      productId: 1111111,
      productName: productSnapshot?['productName'],
      productType: productSnapshot?['productType'],
      productVolume: productSnapshot?['productVolume'],
      imageUrl: productSnapshot?['imageUrl'],
      finalInventoryDate: productSnapshot?['finalInventoryDate'],
      finalInventoryPerson: productSnapshot?['finalInventoryPerson'],
      finalExporterDate: productSnapshot?['finalExporterDate'],
      finalExporterPerson: productSnapshot?['finalExporterPerson'],
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(product.productName)),
          Text(product.productType),
          Text(product.finalInventoryDate),
          Text(product.imageUrl),
          TextButton(
            child: const Text('back'),
            onPressed: () {
              context.go('/stock');
            },
          ),
        ],
      ),
    );
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
part 'product.freezed.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int productId,
    required String productName,
    required String productType,
    required int productVolume,
    required String imageUrl,
    required String finalInventoryDate,
    required String finalInventoryPerson,
    required String finalExporterDate,
    required String finalExporterPerson,
  }) = _Product;
}

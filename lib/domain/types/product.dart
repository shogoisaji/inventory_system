import 'package:freezed_annotation/freezed_annotation.dart';
part 'product.freezed.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int productId,
    required String productName,
    required String productType,
    required String productVolume,
    required String imageUr1,
    required String registrationDate,
    required String finalInventoryDate,
    required String finalInventoryPerson,
    required String finalExporterDate,
    required String finalExporterPerson,
  }) = _Product;
}

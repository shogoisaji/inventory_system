class Product {
  final int id;
  final String name;
  final String category;

  Product({required this.id, required this.name, required this.category});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
    };
  }
}

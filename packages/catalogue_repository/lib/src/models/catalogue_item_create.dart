class CatalogueItemCreate {
  CatalogueItemCreate({
    required this.name,
    required this.detailNumber,
    required this.isRecycled,
    required this.price,
    this.brand,
    this.description,
  });

  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? brand;
  final String? description;

  Map<String, dynamic> toJson() => {
    'name': name,
    'detailNumber': detailNumber,
    'isRecycled': isRecycled,
    'price': price,
    'brand': brand,
    'description': description,
  };
}

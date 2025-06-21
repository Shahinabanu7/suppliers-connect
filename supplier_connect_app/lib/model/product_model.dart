class SupplierDetail {
  final bool success;
  final SupplierInfo supplier;
  final List<Product> products;

  SupplierDetail({
    required this.success,
    required this.supplier,
    required this.products,
  });

  factory SupplierDetail.fromJson(Map<String, dynamic> json) {
    return SupplierDetail(
      success: json['success'],
      supplier: SupplierInfo.fromJson(json['supplier']),
      products: List<Product>.from(
        json['products'].map((x) => Product.fromJson(x)),
      ),
    );
  }
}

class SupplierInfo {
  final int id;
  final String name;
  final String logo;
  final double rating;
  final String category;

  SupplierInfo({
    required this.id,
    required this.name,
    required this.logo,
    required this.rating,
    required this.category,
  });

  factory SupplierInfo.fromJson(Map<String, dynamic> json) {
    return SupplierInfo(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      rating: json['rating'],
      category: json['category'],
    );
  }
}

class Product {
  final int id;
  final String name;
  final String image;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      image: json['image'],
      price: double.parse(json['price'].toString()), // ✅ safe cast
    );
  }
}

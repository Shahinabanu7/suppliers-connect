import 'dart:convert';

Supplier supplierFromJson(String str) => Supplier.fromJson(json.decode(str));

String supplierToJson(Supplier data) => json.encode(data.toJson());

class Supplier {
  bool success;
  List<Datum> data;

  Supplier({required this.success, required this.data});

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String name;
  String logo;
  String rating;
  String category;

  Datum({
    required this.id,
    required this.name,
    required this.logo,
    required this.rating,
    required this.category,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    rating: json["rating"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "rating": rating,
    "category": category,
  };
}

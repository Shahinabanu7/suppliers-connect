// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

OrderResponse orderResponseFromJson(String str) =>
    OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
  bool success;
  String message;
  List<Detail> details;

  OrderResponse({
    required this.success,
    required this.message,
    required this.details,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
    success: json["success"],
    message: json["message"],
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class Detail {
  String name;
  String status;

  Detail({required this.name, required this.status});

  factory Detail.fromJson(Map<String, dynamic> json) =>
      Detail(name: json["name"], status: json["status"]);

  Map<String, dynamic> toJson() => {"name": name, "status": status};
}

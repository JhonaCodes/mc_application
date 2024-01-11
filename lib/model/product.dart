import 'dart:convert';

class Product {
  final String id;
  final String name;
  final dynamic attribute;
  final String currency;
  final String unit;

  Product({
    required this.id,
    required this.name,
    required this.attribute,
    required this.currency,
    required this.unit,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    attribute: json["attribute"],
    currency: json["currency"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "attribute": attribute,
    "currency": currency,
    "unit": unit,
  };
}




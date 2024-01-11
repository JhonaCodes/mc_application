import 'dart:convert';

class Trade {
  final int id;
  final String productId;
  final double price;
  final String etd;
  final String destination;
  final String incoterm;
  final DateTime created;

  Trade({
    required this.id,
    required this.productId,
    required this.price,
    required this.etd,
    required this.destination,
    required this.incoterm,
    required this.created,
  });

  factory Trade.fromRawJson(String str) => Trade.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Trade.fromJson(Map<String, dynamic> json) => Trade(
    id: json["id"],
    productId: json["product_id"],
    price: json["price"]?.toDouble(),
    etd: json["etd"],
    destination: json["destination"],
    incoterm: json["incoterm"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "price": price,
    "etd": etd,
    "destination": destination,
    "incoterm": incoterm,
    "created": created.toIso8601String(),
  };
}

class OrderSummery {
  double total_weight;
  String category_name;
  String price_per_unit;

  OrderSummery(
      {required this.price_per_unit, required this.category_name, required this.total_weight});

  factory OrderSummery.fromJson(Map<String, dynamic> json) => _$OrderSummeryFromJson(json);
}

OrderSummery _$OrderSummeryFromJson(Map<String, dynamic> json) => OrderSummery(
    total_weight: (json['total_weight'] as num).toDouble(),
    category_name: json['category_name'] as String,
    price_per_unit: json['price_per_unit']);

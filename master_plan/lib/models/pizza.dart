class Pizza {
  int id;
  String pizzaName;
  String description;
  double price;
  String imageUrl;

  Pizza.fromJson(Map<String, dynamic> json)
    : id = int.tryParse(json['id'].toString()) ?? 0,
      pizzaName = json['pizzaName']?.toString() ?? '',
      description = json['description']?.toString() ?? '',
      price = double.tryParse(json['price'].toString()) ?? 0.0,
      imageUrl = json['imageUrl']?.toString() ?? '';
}

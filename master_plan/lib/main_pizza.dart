import 'models/pizza.dart';

void main() {
  const pizzaJSON = {
    'id': '123',
    'pizzaName': 'Napoli',
    'description': 'Tasty',
    'price': '12.5',
    'imageUrl': 'img.png',
  };

  final pizza = Pizza.fromJson(pizzaJSON);
  print('Pizza ID: ${pizza.id}');
  print('Pizza Name: ${pizza.pizzaName}');
  print('Pizza Price: ${pizza.price}');
  print('Pizza Image: ${pizza.imageUrl}');
}

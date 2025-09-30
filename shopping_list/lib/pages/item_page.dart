import 'package:flutter/material.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/widgets/footer.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemArgs = ModalRoute.of(context)?.settings.arguments as Item;
    return Scaffold(
      appBar: AppBar(title: Text('Item Page')),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Text(itemArgs.name, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
						Divider(
							height: 10,
							color: Colors.grey,
							thickness: 1,
						),
            Text('Price: ' + itemArgs.price.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            Text('Rating: ' + itemArgs.rating.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            Text('Stock: ' + itemArgs.stock.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            Image.network(itemArgs.imageUrl),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}

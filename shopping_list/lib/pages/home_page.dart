import 'package:flutter/material.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/widgets/footer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Item> items = [
    Item(
      name: 'Sugar',
      price: 5000,
      imageUrl:
          'https://t3.ftcdn.net/jpg/02/94/34/76/360_F_294347652_W3RKypPIHGpnEtGn72J5pC9by14bFntb.jpg',
      rating: 4.2,
      stock: 24,
    ),
    Item(
      name: 'Salt',
      price: 2000,
      imageUrl:
          'https://t3.ftcdn.net/jpg/01/99/90/94/360_F_199909433_VWfq94a6BYtepSIJczsxykqAYuFVEX1Z.jpg',
      rating: 4.7,
      stock: 75,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Container(
        margin: EdgeInsets.all(8),
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/item', arguments: item);
              },
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(child: Text(item.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                      Expanded(
                        child: Text(
                          'Rp. ' + item.price.toString(),
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}

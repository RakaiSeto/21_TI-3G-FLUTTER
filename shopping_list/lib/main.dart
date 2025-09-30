import 'package:flutter/material.dart';
import 'package:shopping_list/pages/home_page.dart';
import 'package:shopping_list/pages/item_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => HomePage(), '/item': (context) => ItemPage()},
    ),
  );
}

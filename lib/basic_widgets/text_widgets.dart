import 'package:flutter/material.dart';

class TextWidgets extends StatelessWidget {
	const TextWidgets({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return const Text(
			"Nama saya Rakai, sedang belajar pemrograman mobile",
			style: TextStyle(color: Colors.red, fontSize: 14),
			textAlign: TextAlign.center,
		);
	}
}
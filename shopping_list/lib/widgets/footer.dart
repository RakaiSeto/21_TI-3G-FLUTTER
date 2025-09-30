import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.grey[200],
        child: const Text(
          'Rakai Seto Sembodo - 2341720135',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

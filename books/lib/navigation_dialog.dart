import 'package:flutter/material.dart';

class NavigationDialog extends StatefulWidget {
  const NavigationDialog({super.key});

  @override
  State<NavigationDialog> createState() => _NavigationDialogState();
}

class _NavigationDialogState extends State<NavigationDialog> {
  Color color = Colors.blue;

  Future _showColorDialog(BuildContext context) async {
    final selected = await showDialog<Color>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Very important question'),
          content: const Text('Please choose a color'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, Colors.red.shade700);
              },
              child: const Text('Red'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, Colors.green.shade700);
              },
              child: const Text('Green'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, Colors.blue.shade700);
              },
              child: const Text('Blue'),
            ),
          ],
        );
      },
    );
    color = selected ?? Colors.blue;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('Navigation Dialog Screen - Rakai'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showColorDialog(context);
          },
          child: const Text('Change Color'),
        ),
      ),
    );
  }
}



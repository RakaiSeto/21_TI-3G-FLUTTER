import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books App - Rakai',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String _result = 'No data';
  bool _isLoading = false;

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Ganti dengan ID buku favorit Anda dari Google Books
      // Contoh: https://www.googleapis.com/books/v1/volumes/{BOOK_ID}
      const path = 'https://www.googleapis.com/books/v1/volumes/zyTCAlFPjgYC';
      final uri = Uri.parse(path);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          _result = jsonData['volumeInfo']['title'] ?? 'No title';
          _isLoading = false;
        });
      } else {
        setState(() {
          _result = 'Error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Books App - Rakai'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _result,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : getData,
              child: const Text('Get Data'),
            ),
          ],
        ),
      ),
    );
  }
}

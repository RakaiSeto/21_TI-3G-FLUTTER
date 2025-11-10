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
  String _asyncResult = 'No data';
  bool _isLoadingAsync = false;

  // Praktikum 1: Menggunakan callback (old way)
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

  // Praktikum 2: Menggunakan async/await untuk menghindari callbacks
  Future<String> fetchBookTitle(String bookId) async {
    final uri = Uri.parse(
      'https://www.googleapis.com/books/v1/volumes/$bookId',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['volumeInfo']['title'] ?? 'No title';
    } else {
      throw Exception('Failed to load book: ${response.statusCode}');
    }
  }

  Future<void> getDataWithAsync() async {
    setState(() {
      _isLoadingAsync = true;
      _asyncResult = 'Loading...';
    });

    try {
      // Menggunakan async/await - lebih clean, tidak ada callback nesting
      final title = await fetchBookTitle('zyTCAlFPjgYC');
      setState(() {
        _asyncResult = title;
        _isLoadingAsync = false;
      });
    } catch (e) {
      setState(() {
        _asyncResult = 'Error: $e';
        _isLoadingAsync = false;
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Praktikum 1: Future & Async/Await',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _result,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ElevatedButton(
              onPressed: _isLoading ? null : getData,
              child: const Text('Get Data'),
            ),
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Praktikum 2: Menggunakan async/await untuk menghindari callbacks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Async/await membuat kode lebih readable dan menghindari callback nesting',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            if (_isLoadingAsync)
              const CircularProgressIndicator()
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _asyncResult,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ElevatedButton(
              onPressed: _isLoadingAsync ? null : getDataWithAsync,
              child: const Text('Get Data with Async/Await'),
            ),
          ],
        ),
      ),
    );
  }
}

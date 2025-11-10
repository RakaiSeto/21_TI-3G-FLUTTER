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
  String _parallelResult = 'No parallel data';
  bool _isLoadingParallel = false;

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

  Future<void> getMultipleData() async {
    setState(() {
      _isLoadingParallel = true;
      _parallelResult = 'Loading...';
    });

    try {
      // Memanggil beberapa Future secara paralel menggunakan Future.wait()
      final futures = [
        http.get(
          Uri.parse('https://www.googleapis.com/books/v1/volumes/zyTCAlFPjgYC'),
        ),
        http.get(
          Uri.parse('https://www.googleapis.com/books/v1/volumes/yqlQEQAAQBAJ'),
        ),
        http.get(
          Uri.parse('https://www.googleapis.com/books/v1/volumes/nMfDDQAAQBAJ'),
        ),
      ];

      // Future.wait() menjalankan semua Future secara paralel
      final responses = await Future.wait(futures);
      final titles = <String>[];

      for (var response in responses) {
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final title = jsonData['volumeInfo']['title'] ?? 'No title';
          titles.add(title);
        } else {
          titles.add('Error: ${response.statusCode}');
        }
      }

      setState(() {
        _parallelResult = titles.join('\n\n');
        _isLoadingParallel = false;
      });
    } catch (e) {
      setState(() {
        _parallelResult = 'Error: $e';
        _isLoadingParallel = false;
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
              'Single Future Call',
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
              child: const Text('Get Single Book Data'),
            ),
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Parallel Future Calls (Future.wait)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (_isLoadingParallel)
              const CircularProgressIndicator()
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _parallelResult,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ElevatedButton(
              onPressed: _isLoadingParallel ? null : getMultipleData,
              child: const Text('Get Multiple Books (Parallel)'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  String _result = '0';
  bool _isLoading = false;
  Completer<int>? completer;

  Future<int> getNumber() {
    completer = Completer<int>();
    return completer!.future;
  }

  Future<void> calculate() async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      completer?.complete(42);
      // Uncomment to simulate error:
      // throw Exception('boom');
    } catch (e) {
      if (!(completer?.isCompleted ?? true)) {
        completer?.completeError(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Back from the Future'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Text(_result, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      setState(() {
                        _isLoading = true;
                      });
                      getNumber()
                          .then((value) {
                            setState(() {
                              _result = value.toString();
                              _isLoading = false;
                            });
                          })
                          .catchError((error) {
                            setState(() {
                              _result = 'An error occurred';
                              _isLoading = false;
                            });
                          });
                      calculate();
                    },
              child: const Text('GO!'),
            ),
          ],
        ),
      ),
    );
  }
}

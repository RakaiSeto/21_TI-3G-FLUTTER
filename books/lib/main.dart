import 'package:flutter/material.dart';
import 'dart:async';
import 'geolocation.dart';

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
      home: const LocationScreen(),
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

  // Praktikum 4 helpers: run in parallel
  Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 3;
  }

  Future<void> returnFutures() async {
    setState(() {
      _isLoading = true;
    });
    final values = await Future.wait<int>([
      returnOneAsync(),
      returnTwoAsync(),
      returnThreeAsync(),
    ]);
    var total = 0;
    for (final element in values) {
      total += element;
    }
    setState(() {
      _result = total.toString();
      _isLoading = false;
    });
  }

  // Praktikum 5: error handling
  Future<void> returnError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('Something terrible happened!');
  }

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

  Future<void> handleError() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await returnError();
      setState(() {
        _result = 'Success';
      });
    } catch (error) {
      setState(() {
        _result = error.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      // ignore: avoid_print
      print('Complete');
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
                      // then/catchError style (kept for reference; final flow uses handleError())
                      // setState(() { _isLoading = true; });
                      // returnError()
                      //     .then((_) {
                      //       setState(() { _result = 'Success'; });
                      //     })
                      //     .catchError((onError) {
                      //       setState(() { _result = onError.toString(); });
                      //     })
                      //     .whenComplete(() {
                      //       setState(() { _isLoading = false; });
                      //       print('Complete');
                      //     });
                      handleError();
                    },
              child: const Text('GO!'),
            ),
          ],
        ),
      ),
    );
  }
}

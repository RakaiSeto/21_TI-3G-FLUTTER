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
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Future Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = '';

  Future<http.Response> getData() async {
    const authority = '7zrw9.wiremockapi.cloud';
    const path = '/pizzalist';

    Uri url = Uri.https(authority, path);
    return await http.get(url);
  }

  Future<http.Response> postData() async {
    const authority = '7zrw9.wiremockapi.cloud';
    const path = '/pizzalist';

    Uri url = Uri.https(authority, path);
    return await http.post(
      url,
      body: json.encode({
        "name": "Pizza Carbonara",
        "description": "Delicious pizza with creamy sauce",
        "price": 15000,
        "imageUrl": "my_image.png",
      }),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            ElevatedButton(
              child: const Text('GET'),
              onPressed: () {
                getData()
                    .then((value) {
                      result = value.body.toString().substring(0, 450);
                      setState(() {});
                    })
                    .catchError((_) {
                      result = 'An error occurred';
                      setState(() {});
                    });
              },
            ),
            ElevatedButton(
              child: const Text('POST'),
              onPressed: () {
                postData()
                    .then((value) {
                      result = value.body.toString().substring(0, 450);
                      setState(() {});
                    })
                    .catchError((_) {
                      result = 'An error occurred';
                      setState(() {});
                    });
              },
            ),
            const Spacer(),
            Text(result),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

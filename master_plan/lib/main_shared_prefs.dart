import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'SharedPreferences Demo'),
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
  int _appCounter = 0;

  @override
  void initState() {
    super.initState();
    _readAndWritePreference();
  }

  Future<void> _readAndWritePreference() async {
    final prefs = await SharedPreferences.getInstance();
    int appCounter = prefs.getInt('appCounter') ?? 0;
    appCounter++;
    await prefs.setInt('appCounter', appCounter);

    setState(() {
      _appCounter = appCounter;
    });
  }

  Future<void> _deletePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // or prefs.remove('appCounter');
    setState(() {
      _appCounter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have opened the app this many times:'),
            Text(
              '$_appCounter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: _deletePreference,
              child: const Text('Reset counter'),
            ),
          ],
        ),
      ),
    );
  }
}

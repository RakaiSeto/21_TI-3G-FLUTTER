## Rakai Seto Sembodo
## TI-3G
## NIM : 2341720135

---

# Praktikum 1: Membuat layanan Mock API

**Soal 1: Tambahkan nama panggilan Anda pada title app sebagai identitas hasil pekerjaan Anda.**
Saya telah menambahkan nama panggilan saya pada `title` di `MaterialApp` dan `AppBar` pada file `main.dart`.
```dart
class MyApp extends StatelessWidget {
  // ...
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rakai Http Demo', // Identitas
      // ...
    );
  }
}
// ...
class MyHomePage extends StatefulWidget {
  // ...
}
```
![Soal 1](http_rakai/img/prak-1.png)
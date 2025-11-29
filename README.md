## Rakai Seto Sembodo

## TI-3G

## NIM : 2341720135

---

### SOAL

**Soal 1: Tambahkan nama panggilan Anda pada title app sebagai identitas pekerjaan Anda. Gantilah warna tema aplikasi sesuai warna kesukaan Anda.**
Saya telah mengubah `title` pada `MaterialApp` menjadi 'Stream Rakai' dan `primarySwatch` menjadi `Colors.teal` di dalam file `main.dart`.

**Soal 2: Tambahkan 5 warna lainnya pada variabel colors tersebut!**
Saya telah menambahkan warna-warna berikut ke dalam list `colors` di `stream.dart`:
```dart
final List<Color> colors = [
  Colors.blueGrey,
  Colors.amber,
  Colors.deepPurple,
  Colors.lightBlue,
  Colors.teal,
];
```

**Soal 3: Jelaskan fungsi keyword yield* pada kode tersebut!**
Keyword `yield*` digunakan untuk mendelegasikan pembuatan event ke stream lain atau iterable lain. Dalam kasus ini, `yield*` meneruskan nilai-nilai yang dihasilkan oleh `Stream.periodic`. Tanpa `yield*`, kita harus melakukan loop manual dan men-yield setiap item satu per satu. `yield*` membuat kode lebih ringkas saat kita ingin mengembalikan seluruh elemen dari stream atau iterable lain.

**Soal 4: Capture hasil praktikum Anda berupa GIF dan lampirkan di README.**
![Soal 4](stream_rakai/img/prak-1.gif)

**Soal 5: Jelaskan perbedaan menggunakan listen dan await for (langkah 9 dan 13)!**
- **listen**: Metode ini mendaftarkan callback yang akan dipanggil setiap kali stream memancarkan event baru. Eksekusi kode di bawah `listen` akan terus berjalan tanpa menunggu stream selesai (non-blocking). Kita perlu mengelola subscription (misalnya membatalkannya) secara manual jika diperlukan.
- **await for**: Ini adalah konstruksi looping asynchronous. Loop ini akan menunggu setiap event dari stream dan memprosesnya satu per satu. Eksekusi kode di dalam fungsi `async` akan "berhenti" (await) di loop ini sampai stream ditutup atau break dipanggil. Ini membuat kode terlihat lebih prosedural dan mudah dibaca untuk alur yang berurutan.

**Soal 6: Jelaskan maksud kode langkah 8 dan 10 tersebut!**
- **Langkah 8 (`initState`)**: Menginisialisasi `NumberStream` dan controller-nya, kemudian mendengarkan (listen) stream tersebut. Setiap kali ada event (angka baru) yang masuk ke stream, callback `listen` akan dijalankan dan `setState` dipanggil untuk memperbarui variabel `lastNumber` dan UI.
- **Langkah 10 (`addRandomNumber`)**: Membuat angka acak antara 0-9 menggunakan `Random`. Angka ini kemudian ditambahkan ke sink dari `NumberStream` menggunakan method `addNumberToSink`. Ini akan memicu aliran data baru di stream yang kemudian ditangkap oleh listener di `initState`.

**Soal 7: Jelaskan maksud kode langkah 13 sampai 15 tersebut!**
- **Langkah 13**: Menambahkan method `addError` pada class `NumberStream` yang berfungsi untuk mengirimkan event error ke sink stream menggunakan `controller.sink.addError`.
- **Langkah 14**: Memodifikasi listener pada `initState` untuk menangani error menggunakan properti `onError`. Jika terjadi error pada stream, callback ini akan dijalankan dan `lastNumber` diubah menjadi -1.
- **Langkah 15**: Memodifikasi `addRandomNumber` agar jika angka acak yang dihasilkan kurang dari 5, angka tersebut ditambahkan ke stream. Namun jika 5 atau lebih, maka `addError` dipanggil untuk memicu error pada stream.
![Soal 7](stream_rakai/img/prak-2.gif)

**Soal 8: Jelaskan maksud kode langkah 1-3 tersebut!**
Kode tersebut menerapkan `StreamTransformer` untuk memanipulasi data stream sebelum diterima oleh listener.
- **Langkah 1**: Mendeklarasikan variabel `transformer` bertipe `StreamTransformer`.
- **Langkah 2**: Menginisialisasi `transformer` dengan `StreamTransformer<int, int>.fromHandlers`. Handler `handleData` akan mengambil data integer dari stream, mengalikannya dengan 10, lalu mengirimkannya ke sink baru. Handler `handleError` akan menangkap error dan mengirimkan nilai -1. Handler `handleDone` akan menutup sink saat stream selesai.
- **Langkah 3**: Menggunakan method `transform(transformer)` pada stream sebelum melakukan `listen`. Ini berarti data yang diterima oleh listener adalah data yang sudah diproses oleh transformer (dikali 10 atau -1 jika error).
![Soal 8](stream_rakai/img/prak-3.gif)

**Soal 9: Jelaskan maksud kode langkah 2, 6 dan 8 tersebut!**
- **Langkah 2**: Pada langkah ini, kita melakukan subscribe ke stream menggunakan method `listen`. Kita juga mendaftarkan callback untuk menangani event error (`onError`) dan ketika stream selesai (`onDone`). `listen` mengembalikan objek `StreamSubscription` yang kita simpan dalam variabel `subscription`.
- **Langkah 6**: Pada method `dispose`, kita memanggil `subscription.cancel()`. Ini sangat penting untuk menghentikan langganan stream ketika widget dihancurkan, sehingga mencegah kebocoran memori (memory leak) dan error karena mencoba memperbarui UI yang sudah tidak ada.
- **Langkah 8**: Pada method `addRandomNumber`, kita menambahkan pengecekan `!numberStreamController.isClosed` sebelum menambahkan data ke sink. Ini memastikan kita tidak mencoba menambahkan data ke stream yang sudah ditutup, yang akan menyebabkan exception 'Bad state: Cannot add new events after calling close'. Jika stream sudah ditutup, kita mengubah state `lastNumber` menjadi -1.

**Soal 10: Jelaskan mengapa error itu bisa terjadi ?**
Error tersebut terjadi karena secara default, `Stream` di Dart adalah "single-subscription". Artinya, stream tersebut hanya boleh memiliki satu pendengar (listener) pada satu waktu. Jika kita mencoba melakukan `listen` lagi pada stream yang sudah memiliki listener aktif, maka akan muncul error `Bad state: Stream has already been listened to`.

**Soal 11: Jelaskan mengapa hal itu bisa terjadi ?**
Hal itu terjadi karena kita telah mengubah stream menjadi "broadcast stream" menggunakan method `asBroadcastStream()`. Broadcast stream memungkinkan banyak listener untuk mendengarkan stream yang sama secara bersamaan. Setiap kali stream memancarkan event, semua listener yang terdaftar akan menerima event tersebut. Dalam kasus ini, kedua subscription (`subscription` dan `subscription2`) menerima event yang sama dan menambahkannya ke variabel `values`, sehingga setiap angka muncul dua kali (atau lebih, tergantung logika penambahannya) di tampilan.
![Soal 11](stream_rakai/img/prak-5.gif)
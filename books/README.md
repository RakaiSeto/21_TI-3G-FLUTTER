# Books - Praktikum 1 & 2: Future & Async/Await

Aplikasi Flutter untuk mempelajari dasar-dasar pemrograman asynchronous menggunakan Future, async/await, dan parallel Future calls.

## Praktikum 1: Single Future Call

### Langkah 1: Buat Project & Tambah Dependency
- Project Flutter baru dengan nama `books`
- Tambah dependency `http: ^1.1.0` di `pubspec.yaml`
- Jalankan `flutter pub get`

### Langkah 2: Cek pubspec.yaml
- Pastikan dependency `http: ^1.1.0` sudah terdaftar

### Langkah 3: Setup main.dart
- Buat `FuturePage` dengan `CircularProgressIndicator`
- Indicator ini menunjukkan aplikasi responsif (tidak freeze)

### Langkah 4: Tambah Method getData()
- Method async untuk mengambil data dari Google Books API
- Menggunakan `await` untuk menunggu HTTP request selesai
- Error handling dengan try-catch

### Langkah 5: Tambah Kode di ElevatedButton
- Tombol "Get Single Book Data" memanggil method `getData()`
- Saat loading, tombol disabled dan menampilkan `CircularProgressIndicator`
- Setelah selesai, menampilkan judul buku dari API

## Praktikum 2: Parallel Future Calls

### Konsep Future.wait()
- `Future.wait()` digunakan untuk menjalankan beberapa Future secara **paralel** (bersamaan)
- Lebih cepat daripada memanggil Future secara berurutan (sequential)
- Semua Future dieksekusi pada waktu yang sama, bukan menunggu satu per satu

### Method getMultipleData()
- Mengambil data dari 3 buku berbeda secara paralel
- Menggunakan `Future.wait()` untuk menjalankan semua HTTP request bersamaan
- Menampilkan semua judul buku setelah semua request selesai

### Perbedaan Sequential vs Parallel

**Sequential (Berurutan):**
```dart
// Lambat - menunggu satu per satu
final book1 = await http.get(uri1);  // tunggu 2 detik
final book2 = await http.get(uri2);  // tunggu 2 detik lagi
final book3 = await http.get(uri3);  // tunggu 2 detik lagi
// Total: 6 detik
```

**Parallel (Bersamaan):**
```dart
// Cepat - semua jalan bersamaan
final futures = [http.get(uri1), http.get(uri2), http.get(uri3)];
final results = await Future.wait(futures);
// Total: 2 detik (waktu terpanjang)
```

## Cara Menggunakan

1. **Single Future Call:**
   - Klik tombol "Get Single Book Data"
   - Akan mengambil data 1 buku dari API
   - Menampilkan judul buku

2. **Parallel Future Calls:**
   - Klik tombol "Get Multiple Books (Parallel)"
   - Akan mengambil data 3 buku secara bersamaan
   - Menampilkan semua judul buku setelah selesai
   - **Lebih cepat** karena semua request jalan paralel

## Dependencies

- `http: ^1.1.0` - Untuk HTTP requests ke Google Books API

## Catatan

- Untuk macOS, pastikan network permission sudah ditambahkan di `macos/Runner/Release.entitlements`
- CircularProgressIndicator akan berputar saat proses async berjalan
- Parallel calls lebih efisien untuk multiple requests yang independen
- Ganti ID buku di method `getData()` dan `getMultipleData()` dengan ID buku favorit Anda

# Books - Praktikum 1, 2 & 3: Future, Async/Await & FutureBuilder

Aplikasi Flutter untuk mempelajari dasar-dasar pemrograman asynchronous menggunakan Future, async/await, parallel Future calls, dan FutureBuilder.

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

## Praktikum 3: FutureBuilder

### Konsep FutureBuilder
- Widget yang secara otomatis mengelola Future dan rebuild UI ketika Future selesai
- Tidak perlu `setState()` manual untuk update UI
- Menangani 3 state: `waiting`, `done (success)`, `done (error)`
- Lebih clean dan reactive dibandingkan manual state management

### File: `lib/geolocation.dart`
- `LocationScreen` menggunakan `FutureBuilder` untuk menampilkan koordinat GPS
- Future diinisialisasi di `initState()` dan disimpan sebagai variabel
- `FutureBuilder` otomatis rebuild ketika Future selesai

### Struktur FutureBuilder

```dart
FutureBuilder<Position>(
  future: position,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return Text('Error occurred');
      }
      return Text(snapshot.data.toString());
    }
    return Text('Waiting...');
  },
)
```

### Keuntungan FutureBuilder
1. **Auto-rebuild**: UI otomatis update ketika Future selesai
2. **No setState needed**: Tidak perlu manual `setState()` untuk update UI
3. **Error handling built-in**: Bisa handle error langsung di builder
4. **Clean code**: Kode lebih sederhana dan mudah dibaca

### Perbedaan dengan Manual State Management

**Manual (dengan setState):**
```dart
// Perlu setState manual
Future<void> getData() async {
  setState(() => _isLoading = true);
  try {
    final data = await fetchData();
    setState(() {
      _isLoading = false;
      _result = data;
    });
  } catch (e) {
    setState(() {
      _isLoading = false;
      _error = e;
    });
  }
}
```

**Dengan FutureBuilder:**
```dart
// Otomatis, tidak perlu setState
FutureBuilder(
  future: fetchData(),
  builder: (context, snapshot) {
    // Auto rebuild ketika Future selesai
  },
)
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

3. **FutureBuilder Example:**
   - Klik tombol "Open FutureBuilder Example"
   - Akan membuka screen baru dengan `FutureBuilder`
   - Menampilkan loading indicator, lalu koordinat GPS
   - **Tidak perlu setState manual**, FutureBuilder handle semuanya

## Dependencies

- `http: ^1.1.0` - Untuk HTTP requests ke Google Books API

## Catatan

- Untuk macOS, pastikan network permission sudah ditambahkan di `macos/Runner/Release.entitlements`
- CircularProgressIndicator akan berputar saat proses async berjalan
- Parallel calls lebih efisien untuk multiple requests yang independen
- FutureBuilder lebih efisien untuk Future yang tidak perlu di-trigger ulang
- Ganti ID buku di method `getData()` dan `getMultipleData()` dengan ID buku favorit Anda

# Books - Praktikum 1: Future & Async/Await

Aplikasi Flutter untuk mempelajari dasar-dasar pemrograman asynchronous menggunakan Future dan async/await.

## Langkah-langkah Praktikum 1

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
- Tombol "Get Data" memanggil method `getData()`
- Saat loading, tombol disabled dan menampilkan `CircularProgressIndicator`
- Setelah selesai, menampilkan judul buku dari API

## Cara Menggunakan

1. Ganti ID buku di method `getData()` dengan ID buku favorit Anda dari Google Books
   - Buka Google Books, cari buku favorit
   - Copy ID dari URL: `https://www.googleapis.com/books/v1/volumes/{BOOK_ID}`
   - Ganti `zyTCAlFPjgYC` dengan ID buku Anda

2. Run aplikasi dengan `flutter run`

3. Klik tombol "Get Data" untuk mengambil data buku dari API

## Dependencies

- `http: ^1.1.0` - Untuk HTTP requests ke Google Books API

## Catatan

- Untuk macOS, pastikan network permission sudah ditambahkan di `macos/Runner/Release.entitlements`
- CircularProgressIndicator akan berputar saat proses async berjalan, menunjukkan aplikasi tetap responsif

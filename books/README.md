# Books - Praktikum 1-5: Future, Async/Await, FutureBuilder, Async Navigation & Async Dialog

Aplikasi Flutter untuk mempelajari dasar-dasar pemrograman asynchronous menggunakan Future, async/await, parallel Future calls, FutureBuilder, Async Navigation, dan Async Dialog.

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

## Praktikum 4: Async Navigation

### Konsep Async Navigation
- `Navigator.push()` mengembalikan `Future<T>`
- Bisa menggunakan `await` untuk menunggu hasil dari screen berikutnya
- Screen kedua bisa mengembalikan nilai menggunakan `Navigator.pop(context, value)`
- Screen pertama menerima nilai dan bisa update state

### File: `lib/navigation_first.dart` & `lib/navigation_second.dart`

**NavigationFirst:**
- Screen pertama dengan background color yang bisa berubah
- Method `_navigateAndGetColor()` menggunakan `await Navigator.push()`
- Menerima warna dari screen kedua dan update background

**NavigationSecond:**
- Screen kedua dengan 3 tombol warna (Red, Green, Orange)
- Setiap tombol memanggil `Navigator.pop(context, color)`
- Mengembalikan warna ke screen pertama

### Struktur Async Navigation

```dart
// Screen pertama
Future<void> _navigateAndGetColor(BuildContext context) async {
  color = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const NavigationSecond(),
    ),
  ) ?? Colors.blue;  // Default color jika null
  setState(() {});  // Update UI dengan warna baru
}

// Screen kedua
ElevatedButton(
  onPressed: () {
    Navigator.pop(context, Colors.red);  // Return warna ke screen pertama
  },
  child: Text('Red'),
)
```

### Keuntungan Async Navigation
1. **Two-way communication**: Screen bisa mengirim data ke screen sebelumnya
2. **Clean pattern**: Lebih mudah daripada callback atau global state
3. **Type-safe**: Bisa specify tipe data yang dikembalikan
4. **Flexible**: Bisa return berbagai tipe data (String, int, Color, dll)

## Praktikum 5: Async Dialog

### Konsep Async Dialog
- `showDialog()` mengembalikan `Future<T>`
- Bisa menggunakan `await` untuk menunggu hasil dari dialog
- Dialog bisa mengembalikan nilai menggunakan `Navigator.pop(context, value)`
- Lebih clean daripada callback pattern

### File: `lib/navigation_dialog.dart`
- Screen dengan background color yang bisa berubah
- Method `_showColorDialog()` menggunakan `await showDialog()`
- Dialog menampilkan 3 pilihan warna (Red, Green, Orange)
- Setiap pilihan memanggil `Navigator.pop(context, color)`
- Background screen berubah sesuai warna yang dipilih

### Struktur Async Dialog

```dart
Future<void> _showColorDialog() async {
  final result = await showDialog<Color>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose Color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.color_lens, color: Colors.red),
              title: Text('Red'),
              onTap: () => Navigator.pop(context, Colors.red),
            ),
            // ... more options
          ],
        ),
      );
    },
  );

  if (result != null) {
    setState(() {
      color = result;  // Update background color
    });
  }
}
```

### Keuntungan Async Dialog
1. **Clean pattern**: Lebih mudah daripada callback
2. **Type-safe**: Bisa specify tipe data yang dikembalikan
3. **Flexible**: Bisa return berbagai tipe data
4. **User-friendly**: Dialog lebih familiar untuk user input

### Perbedaan dengan Callback Pattern

**Callback Pattern (lama):**
```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          onColorSelected(Colors.red);  // Callback
        },
        child: Text('Red'),
      ),
    ],
  ),
);
```

**Async Pattern (baru):**
```dart
final result = await showDialog<Color>(
  context: context,
  builder: (context) => AlertDialog(...),
);
if (result != null) {
  setState(() => color = result);  // Langsung update
}
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

4. **Async Navigation:**
   - Klik tombol "Open Async Navigation Example"
   - Akan membuka screen dengan background biru
   - Klik "Change Color" untuk membuka screen kedua
   - Pilih warna (Red, Green, atau Orange)
   - Background screen pertama akan berubah sesuai warna yang dipilih
   - **Menggunakan await untuk mendapatkan hasil dari screen kedua**

5. **Async Dialog:**
   - Klik tombol "Open Async Dialog Example"
   - Akan membuka screen dengan background biru
   - Klik "Change Color" untuk membuka dialog
   - Pilih warna dari dialog (Red, Green, atau Orange)
   - Background screen akan berubah sesuai warna yang dipilih
   - **Menggunakan await untuk mendapatkan hasil dari dialog**

## Dependencies

- `http: ^1.1.0` - Untuk HTTP requests ke Google Books API

## Catatan

- Untuk macOS, pastikan network permission sudah ditambahkan di `macos/Runner/Release.entitlements`
- CircularProgressIndicator akan berputar saat proses async berjalan
- Parallel calls lebih efisien untuk multiple requests yang independen
- FutureBuilder lebih efisien untuk Future yang tidak perlu di-trigger ulang
- Async Navigation memungkinkan komunikasi dua arah antara screens
- Async Dialog lebih clean daripada callback pattern untuk user input
- Ganti ID buku di method `getData()` dan `getMultipleData()` dengan ID buku favorit Anda

## Rakai Seto Sembodo

## TI-3G

## NIM : 2341720135

---

### SOAL

**3. Jelaskan maksud kode langkah 5 tersebut terkait substring dan catchError!**
Kode pada langkah 5 memanfaatkan operasi `substring` untuk mengekstraksi bagian tertentu dari sebuah string sesuai indeks yang dibutuhkan. Selain itu, digunakan pula `catchError` guna menangani kemungkinan kegagalan pada proses asynchronous (misalnya ketika permintaan data buku tidak berhasil). Dengan mekanisme ini, alur eksekusi tetap terjaga dan aplikasi dapat menampilkan informasi kesalahan secara terkontrol.
![Praktikum 1](books/img/Soal3.gif)

**4. Jelaskan maksud kode langkah 1 dan 2 tersebut!**
Langkah 1 mendefinisikan tiga fungsi asynchronous (`returnOneAsync`, `returnTwoAsync`, `returnThreeAsync`) yang masing‑masing menunggu 2 detik menggunakan `Future.delayed` sebelum mengembalikan nilai 1, 2, dan 3. Ketiga fungsi tersebut mensimulasikan pekerjaan yang memerlukan waktu (I/O) dan mengembalikan `Future<int>` sehingga harus dipanggil dengan `await`.

Langkah 2 menambahkan fungsi `count()` (asynchronous) yang menjalankan ketiga fungsi sebelumnya secara berurutan dengan `await`, menjumlahkan hasilnya ke dalam variabel `total`, kemudian memanggil `setState` untuk memperbarui UI dengan nilai akhir. Karena dieksekusi secara sequential, total waktu eksekusi sekitar 6 detik (2+2+2), dan indikator pemuatan ditampilkan hanya selama proses berlangsung.

![Praktikum 2](books/img/Soal4.gif)

**5. Jelaskan maksud kode langkah 2 tersebut!**
Langkah 2 memperkenalkan penggunaan `Completer<int>` untuk membuat sebuah `Future` yang penyelesaiannya dapat dikendalikan secara manual. Fungsi `getNumber()` menginisialisasi objek `Completer` baru dan segera mengembalikan `completer.future` sehingga pihak pemanggil dapat menunggu hasilnya. Fungsi `calculate()` melakukan penundaan selama 5 detik dan kemudian memanggil `completer.complete(42)` agar `Future` berubah status menjadi selesai (completed) dengan nilai 42. Pendekatan ini memisahkan pihak yang menunggu nilai dan pihak yang menyediakan nilai sehingga alur asynchronous tetap tertata dan non‑blocking.

**6. Jelaskan maksud perbedaan kode langkah 2 dengan langkah 5-6 tersebut!**
Pada langkah 2, alur yang ditunjukkan merupakan skenario keberhasilan (happy path) semata: setelah penundaan, `Future` diselesaikan dengan `complete(42)` dan callback `then(...)` memperbarui UI. Pada langkah 5–6, alur tersebut dilengkapi dengan penanganan kesalahan: `calculate()` dibungkus dengan blok `try/catch` dan apabila terjadi kegagalan, `completer.completeError(e)` dipanggil; di sisi pemanggil, method `onPressed` menambahkan `.catchError(...)` untuk menampilkan pesan kesalahan pada UI. Dengan demikian, perbedaannya terletak pada keberadaan mekanisme propagasi dan penanganan error pada langkah 5–6 yang tidak ada pada langkah 2.

**7. Capture GIF**
![Praktikum 7](books/img/Soal7.gif)

**8. Jelaskan maksud perbedaan kode langkah 1 dan 4!**
Pada langkah 1 digunakan `FutureGroup` (dari paket `async`) untuk mengelola sekumpulan `Future` yang dijalankan secara paralel. Setiap `Future` didaftarkan ke dalam grup, dan ketika seluruhnya selesai, grup menghasilkan sebuah `List<int>` yang kemudian diproses (misalnya dijumlahkan). Pendekatan ini memberi kontrol lebih terhadap manajemen kumpulan tugas asynchronous, seperti menambah item secara eksplisit dan memproses hasil kolektifnya.

Pada langkah 4, pendekatan yang sama (eksekusi paralel) diwujudkan dengan API inti Dart, yaitu `Future.wait<int>([ ... ])`. Metode ini lebih ringkas dan idiomatis, langsung mengeksekusi semua `Future` secara bersamaan dan mengembalikan `List<int>` ketika seluruhnya selesai. Perbedaan utamanya terletak pada cara manajemen: `FutureGroup` adalah utilitas manajemen kumpulan `Future`, sedangkan `Future.wait` merupakan cara standar dan sederhana untuk menunggu banyak `Future` secara paralel dengan sedikit kode dan dependensi.

**9. Capture GIF**
![Praktikum 9](books/img/Soal9.gif)

**10. Panggil method handleError() tersebut di ElevatedButton, lalu run. Apa hasilnya? Jelaskan perbedaan kode langkah 1 dan 4!**
Ketika tombol dijalankan, aplikasi menampilkan indikator pemuatan selama ±2 detik. Setelah `returnError()` melempar pengecualian, teks hasil pada UI berubah menjadi pesan galat (misal: `Exception: Something terrible happened!`), indikator pemuatan dihentikan, dan log konsol menampilkan `Complete`. Dengan demikian, alur eksekusi dan pemulihan UI berjalan terkendali meskipun terjadi error.

Perbedaan langkah 1 dan 4 adalah gaya penanganan error:

-   Langkah 1 menggunakan rantai callback `then(...).catchError(...).whenComplete(...)`. Error diproses pada callback `catchError`, sedangkan pembersihan status dilakukan di `whenComplete`. Gaya ini bersifat callback‑based.
-   Langkah 4 menggunakan `async/await` dengan blok `try/catch/finally` pada fungsi `handleError()`. Error ditangani di `catch`, dan pembersihan status dijamin dieksekusi di `finally`. Gaya ini lebih terstruktur, mudah dibaca, dan lebih dekat dengan alur sinkron, sehingga memudahkan pemeliharaan.

**12. Apakah Anda mendapatkan koordinat GPS ketika run di browser? Mengapa demikian?**
Secara umum tidak. Pada eksekusi melalui browser (Flutter Web), akses lokasi mengandalkan HTML5 Geolocation API yang hanya berfungsi pada secure context (HTTPS atau `localhost`) dan wajib memperoleh persetujuan pengguna. Tanpa konteks aman atau bila izin ditolak, plugin tidak dapat mengembalikan koordinat. Selain itu, akurasi setara GPS perangkat tidak tersedia pada browser; data lokasi (jika ada) biasanya berupa perkiraan berbasis Wi‑Fi/IP sehingga tidak seakurat pada perangkat/emulator.

![Praktikum 11](books/img/Soal11.gif)

**13. Apakah ada perbedaan UI dengan praktikum sebelumnya? Mengapa demikian?**
Ya. Dengan `FutureBuilder`, tampilan loading dan hasil data dikelola oleh widget itu sendiri berdasarkan `snapshot.connectionState` dan `snapshot.data/error`. UI menjadi lebih reaktif dan “clean” karena tidak membutuhkan pemanggilan `setState` manual untuk setiap perubahan state Future; rebuild hanya terjadi pada subtree yang dibungkus `FutureBuilder`.
![Praktikum 11](books/img/Soal11.gif)

**14. Apakah ada perbedaan UI dengan langkah sebelumnya? Mengapa demikian?**
Ada. Setelah penambahan blok error handling pada `FutureBuilder`, UI kini dapat menampilkan pesan kesalahan ketika `snapshot.hasError` bernilai true. Sebelumnya, cabang ini belum ada sehingga UI hanya menampilkan hasil posisi atau indikator loading. Penanganan ini membuat UI lebih robust terhadap kegagalan asynchronous.
![Praktikum 11](books/img/Soal11.gif)

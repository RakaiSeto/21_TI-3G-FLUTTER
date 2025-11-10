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

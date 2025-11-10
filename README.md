## Rakai Seto Sembodo

## TI-3G

## NIM : 2341720135

---

### SOAL

**3. Jelaskan maksud kode langkah 5 tersebut terkait substring dan catchError!**
kode langkah 5 tersebut terkait substring dan catchError adalah kode untuk menangani error yang terjadi saat pencarian data buku.
![Praktikum 1](books/img/Soal3.gif)

**4. Jelaskan maksud kode langkah 1 dan 2 tersebut!**
Langkah 1 bikin tiga fungsi async (`returnOneAsync`, `returnTwoAsync`, `returnThreeAsync`) yang masing‑masing nunggu 2 detik (`Future.delayed`) lalu ngembaliin angka 1, 2, dan 3. Ini nge-simulasikan kerjaan yang butuh waktu (I/O) dan hasilnya dibungkus `Future<int>` jadi wajib di‑`await`.

Langkah 2 nambahin `count()` sebagai fungsi `async` yang ngejalanin ketiga fungsi tadi secara berurutan pakai `await`, ngejumlah hasilnya ke `total`, terus `setState` buat update UI dengan nilai total. Karena dijalankan sequential, durasinya ~6 detik (2+2+2), dan indikator loading cuma muncul saat proses jalan.

![Praktikum 2](books/img/Soal4.gif)


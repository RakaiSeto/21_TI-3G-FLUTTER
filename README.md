## Rakai Seto Sembodo

## TI-3G

## NIM : 2341720135

---

### Praktikum 1

**2. Jelaskan maksud dari langkah 4 pada praktikum tersebut! Mengapa dilakukan demikian?**
[JAWAB] Langkah 4 bikin `models/data_layer.dart` yang cuma `export 'plan.dart';` dan `export 'task.dart';`. Tujuannya biar import di view cukup sekali ke `data_layer.dart`, bukan nyebar import ke tiap file model. Hasilnya: import lebih rapi, gampang refactor, dan konsisten akses model.

**3. Mengapa perlu variabel plan di langkah 6 pada praktikum tersebut? Mengapa dibuat konstanta ?**
[JAWAB] Di `PlanScreen`, kita butuh `plan` sebagai state lokal layar untuk ngebuild list tugas dan ngebikin salinan baru saat ada perubahan (immutability). Awalnya di‑init `const Plan()` biar punya nilai default yang aman, immutable, dan bisa dipakai sebagai baseline sebelum user nambah task. Nanti setiap update, kita bikin objek `Plan` baru (copy with changes), bukan ngubah yang lama—ini bikin UI rebuild dengan bersih.

**4. Lakukan capture hasil dari Langkah 9 berupa GIF, kemudian jelaskan apa yang telah Anda buat!**
![Praktikum 1](master_plan/img/langkah9.gif)
[JAWAB] Ini screen detail “Master Plan” berisi daftar `Task` dengan:

-   Checkbox buat toggle `complete`.
-   `TextFormField` per item buat edit `description` langsung di list.
-   FAB (+) buat nambah task kosong di akhir.
    Semua perubahan dilakukan secara immutable: kita salin `List<Task>` lalu ganti item/append, terus set ke state/notifier supaya UI auto‑rebuild.

**5. Apa kegunaan method pada Langkah 11 dan 13 dalam lifecyle state ?**
[JAWAB]

-   Langkah 11 – `build(...)`: method lifecycle inti yang nge‑render UI. Dipanggil pertama kali saat widget dibuat dan setiap kali `setState` jalan. Semua tampilan (creator list, daftar plan) dibangun di sini.
-   Langkah 13 – `addPlan()`: bukan lifecycle method, tapi fungsi yang mengubah state: ambil teks, bikin `Plan` baru, update `ValueNotifier<List<Plan>>`, clear text, dan `setState()` buat trigger rebuild. Ini bagian “update state → rebuild UI” dalam siklus hidup widget. (Lifecycle terkait lain dari langkah sebelumnya: `dispose()` buat ngebersihin `TextEditingController` saat widget di‑unmount).

### Praktikum 2

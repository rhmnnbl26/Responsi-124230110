Link API :
News : https://api.spaceflightnewsapi.net/v4/articles/
Blogs : https://api.spaceflightnewsapi.net/v4/blogs/
Report : https://api.spaceflightnewsapi.net/v4/reports/
Untuk detail data news, blogs, atau report, diakses berdasarkan id nya :
https://api.spaceflightnewsapi.net/v4/{menu}/{id}/
Contoh Akses API :
https://api.spaceflightnewsapi.net/v4/articles/27413/
Dokumentasi : https://api.spaceflightnewsapi.net/v4/docs/
Soal RESPONSI
1. Login Page
- Buat halaman login dengan 2 kolom input: [username] [password]
- Jika login berhasil, arahkan (navigasi) ke Halaman Home.
- Gunakan Local database untuk menyimpan data login (Shared Preference).
Home Page
- Appbar menampilkan username yang sedang login.
- Menampilkan List artikel sesuai menu yang dipilih
3. Detail Page
- Halaman ini berisi detail dari news, report, atau blog yang dipilih. Setiap
halaman detail pada news, report, atau blog yang diklik, buat sebuah tombol
floating button yang mengarahkan ke halaman web news, blog, atau report
tersebut.
4. Favorite Page
- Terdapat AppBar.
- Terdapat List data favorite yang ditambahkan oleh pengguna.
- Favorite bisa dihapus dengan cara swipe ke kiri atau ke kanan.
- Terdapat snackbar ketika item sudah dihapus
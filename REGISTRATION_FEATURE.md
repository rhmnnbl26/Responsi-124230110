# Fitur Registrasi

## Deskripsi
Halaman registrasi telah ditambahkan ke aplikasi Spaceflight News. User dapat membuat akun baru dengan mengisi form registrasi.

## Teknologi yang Digunakan
- **Hive Database**: Untuk menyimpan data user secara lokal
- **SharedPreferences**: Untuk session management
- **Flutter Form Validation**: Validasi input user

## Fitur
1. Form registrasi dengan field:
   - Email
   - Username
   - Password
   - Confirm Password

2. Validasi input:
   - Email harus valid (minimal 5 karakter dan mengandung @)
   - Username minimal 3 karakter
   - Password minimal 6 karakter
   - Confirm password harus sama dengan password

3. Auto login setelah registrasi berhasil

4. Integrasi dengan Hive database untuk menyimpan user data

## Code Structure (Messy by Design)
Code dibuat dengan beberapa masalah dan anti-patterns untuk tujuan pembelajaran:

### Problems yang Ditambahkan:
1. **Unused Variables**: Variabel yang tidak digunakan di beberapa file
2. **Duplicate Methods**: Method yang fungsinya sama tapi berbeda nama
3. **Messy Validation**: Validasi yang berulang dan tidak efisien
4. **Duplicate Checks**: Pengecekan kondisi yang sama dilakukan beberapa kali
5. **Poor Error Handling**: Error handling yang minimal
6. **Security Issue**: Password disimpan dalam plain text (intentional)
7. **Unused Imports**: Import yang tidak terpakai
8. **Unused Classes**: Helper classes yang tidak digunakan
9. **Empty Methods**: Method yang tidak melakukan apa-apa
10. **Inefficient Loops**: Iterasi yang tidak efisien

## Files Modified/Created:
- `lib/screens/register_screen.dart` - New registration screen
- `lib/models/user_model.dart` - User model untuk Hive
- `lib/models/user_model.g.dart` - Generated Hive adapter
- `lib/services/auth_service.dart` - Updated dengan register method
- `lib/screens/login_screen.dart` - Tambah link ke register
- `lib/main.dart` - Tambah Hive initialization
- `lib/helpers/validation_helper.dart` - Helper untuk validasi (unused)
- `pubspec.yaml` - Tambah dependencies Hive

## Cara Menggunakan:
1. Buka aplikasi
2. Di halaman login, klik "Register"
3. Isi form registrasi
4. Klik tombol "Register"
5. Akan otomatis login dan masuk ke home screen

## Known Issues (Intentional):
- Validasi email sangat sederhana
- Password disimpan tanpa enkripsi
- Banyak code duplikasi
- Beberapa unused variables dan methods
- Error handling minimal
- Validation logic yang messy

## Note:
Code ini sengaja dibuat berantakan dan tidak mengikuti best practices untuk tujuan pembelajaran dan demonstrasi. Jangan gunakan code pattern seperti ini di production!

# 🎮 Nintendo Amiibo App

Aplikasi Flutter untuk menampilkan koleksi Nintendo Amiibo dengan fitur favorites menggunakan local storage.

## ✨ Fitur Utama

### 🏠 Home Screen
- ✅ Menampilkan list semua Nintendo Amiibo dari API
- ✅ Search & filter amiibo
- ✅ Pull to refresh
- ✅ Loading state & error handling
- ✅ Tambah/hapus favorite dengan icon ❤️
- ✅ Klik item untuk lihat detail

### 📱 Detail Screen
- ✅ Tampilan detail lengkap amiibo
- ✅ Informasi: Name, Character, Game Series, Type, Release Date, dll
- ✅ Toggle favorite dari detail screen
- ✅ Hero animation untuk smooth transition

### ⭐ Favorite Screen
- ✅ List amiibo yang sudah difavorite
- ✅ Swipe left/right untuk hapus favorite
- ✅ Confirmation dialog sebelum hapus
- ✅ Undo action dengan snackbar
- ✅ Empty state illustration
- ✅ Data disimpan di SharedPreferences (persistent)

### 🎨 Fitur Tambahan
- ✅ Bottom Navigation Bar
- ✅ Tema Nintendo (merah & putih)
- ✅ Image caching untuk performa optimal
- ✅ Responsive UI
- ✅ Smooth animations

## 🚀 Cara Menjalankan

1. **Clone/Download project ini**

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run aplikasi**
   ```bash
   flutter run
   ```

## 📦 Dependencies

- `http: ^1.2.0` - HTTP requests ke API
- `shared_preferences: ^2.2.2` - Local storage untuk favorites
- `cached_network_image: ^3.3.1` - Image caching

## 🌐 API

Aplikasi ini menggunakan [Amiibo API](https://www.amiiboapi.com/)
- Base URL: `https://www.amiiboapi.com/`
- Endpoint: `/api/amiibo`
- Dokumentasi: https://www.amiiboapi.com/docs/

## 📂 Struktur Project

```
lib/
├── main.dart                    # Entry point & navigation
├── models/
│   └── amiibo_model.dart       # Data model
├── services/
│   ├── api_service.dart        # API service
│   └── favorite_service.dart   # Favorite management
└── screens/
    ├── home_screen.dart        # Home screen
    ├── detail_screen.dart      # Detail screen
    └── favorite_screen.dart    # Favorite screen
```

## 📖 Dokumentasi Lengkap

Lihat file [LANGKAH_PENGERJAAN.md](LANGKAH_PENGERJAAN.md) untuk:
- Langkah-langkah pembuatan aplikasi
- Penjelasan detail setiap kode
- Konsep Flutter yang digunakan
- Best practices
- Tips & troubleshooting

## 🎓 Teknologi & Konsep

- Flutter & Dart
- RESTful API Integration
- Local Storage (SharedPreferences)
- State Management (setState)
- Navigation & Routing
- Asynchronous Programming
- JSON Parsing
- Material Design 3

## 📸 Screenshots

(Jalankan aplikasi untuk melihat tampilan)

## 📝 Catatan

- Aplikasi memerlukan koneksi internet untuk load data amiibo
- Data favorites disimpan secara lokal (tidak hilang saat app ditutup)
- Swipe horizontal (kiri/kanan) untuk hapus favorite
- Gunakan search untuk mencari amiibo spesifik

## 👨‍💻 Development

Dibuat untuk latihan Flutter dengan mengikuti best practices:
- Clean code & proper structure
- Separation of concerns
- Error handling
- User-friendly UI/UX
- Performance optimization

---

**Built with ❤️ using Flutter**


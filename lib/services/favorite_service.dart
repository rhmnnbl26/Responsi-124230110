import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article_model.dart';

/// Service class untuk handle favorite articles menggunakan SharedPreferences
class FavoriteService {
  static const String _favoritesKey = 'favorite_articles';
  
  // Singleton instance
  static final FavoriteService _instance = FavoriteService._internal();
  factory FavoriteService() => _instance;
  FavoriteService._internal();

  List<Article>? _cachedFavorites;

  /// Method untuk mendapatkan semua favorite articles
  Future<List<Article>> getFavorites() async {
    if (_cachedFavorites != null) {
      return _cachedFavorites!;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? favoritesJson = prefs.getString(_favoritesKey);
      
      if (favoritesJson == null || favoritesJson.isEmpty) {
        _cachedFavorites = [];
        return [];
      }
      
      final List<dynamic> favoritesList = json.decode(favoritesJson);
      _cachedFavorites = favoritesList
          .map((item) => Article.fromJson(item))
          .toList();
      
      return _cachedFavorites!;
    } catch (e) {
      print('Error loading favorites: $e');
      _cachedFavorites = [];
      return [];
    }
  }

  /// Method untuk menyimpan favorites ke local storage
  Future<bool> saveFavorites(List<Article> favorites) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> favoritesJson = 
          favorites.map((article) => article.toJson()).toList();
      
      final String jsonString = json.encode(favoritesJson);
      final bool success = await prefs.setString(_favoritesKey, jsonString);
      
      if (success) {
        _cachedFavorites = favorites;
      }
      
      return success;
    } catch (e) {
      print('Error saving favorites: $e');
      return false;
    }
  }

  /// Method untuk menambah article ke favorites
  Future<bool> addFavorite(Article article) async {
    try {
      final favorites = await getFavorites();
      
      if (favorites.any((fav) => fav.id == article.id)) {
        return false;
      }
      
      favorites.add(article);
      return await saveFavorites(favorites);
    } catch (e) {
      print('Error adding favorite: $e');
      return false;
    }
  }

  /// Method untuk menghapus article dari favorites
  Future<bool> removeFavorite(Article article) async {
    try {
      final favorites = await getFavorites();
      favorites.removeWhere((fav) => fav.id == article.id);
      return await saveFavorites(favorites);
    } catch (e) {
      print('Error removing favorite: $e');
      return false;
    }
  }

  /// Method untuk toggle favorite
  Future<bool> toggleFavorite(Article article) async {
    final isFavorite = await isFavorited(article);
    
    if (isFavorite) {
      await removeFavorite(article);
      return false;
    } else {
      await addFavorite(article);
      return true;
    }
  }

  /// Method untuk check apakah article sudah difavorite
  Future<bool> isFavorited(Article article) async {
    final favorites = await getFavorites();
    return favorites.any((fav) => fav.id == article.id);
  }

  /// Method untuk clear semua favorites
  Future<bool> clearAllFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final success = await prefs.remove(_favoritesKey);
      
      if (success) {
        _cachedFavorites = [];
      }
      
      return success;
    } catch (e) {
      print('Error clearing favorites: $e');
      return false;
    }
  }

  /// Method untuk get jumlah favorites
  Future<int> getFavoritesCount() async {
    final favorites = await getFavorites();
    return favorites.length;
  }

  /// Method untuk refresh cache
  void refreshCache() {
    _cachedFavorites = null;
  }
}

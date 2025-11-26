import 'package:shared_preferences/shared_preferences.dart';

/// Service untuk handle autentikasi menggunakan SharedPreferences
class AuthService {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _usernameKey = 'username';
  static const String _passwordKey = 'password';
  
  // Singleton instance
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  /// Method untuk login
  Future<bool> login(String username, String password) async {
    try {
      if (username.isEmpty || password.isEmpty) {
        return false;
      }
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_usernameKey, username);
      await prefs.setString(_passwordKey, password);
      
      return true;
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }

  /// Method untuk logout
  Future<bool> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, false);
      await prefs.remove(_usernameKey);
      await prefs.remove(_passwordKey);
      
      return true;
    } catch (e) {
      print('Error during logout: $e');
      return false;
    }
  }

  /// Method untuk check apakah user sudah login
  Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_isLoggedInKey) ?? false;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  /// Method untuk get username yang sedang login
  Future<String?> getUsername() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_usernameKey);
    } catch (e) {
      print('Error getting username: $e');
      return null;
    }
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';

/// Service untuk handle autentikasi menggunakan SharedPreferences dan Hive
class AuthService {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _usernameKey = 'username';
  static const String _passwordKey = 'password';
  static const String _userBoxName = 'users';
  
  // Singleton instance
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Messy initialization (no error handling)
  Future<void> initHive() async {
    await Hive.initFlutter();
    if(!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    await Hive.openBox<User>(_userBoxName);
  }

  // Method untuk register user baru (messy code)
  Future<bool> register(String username, String password, String email) async {
    try {
      // Initialize Hive if not initialized
      if(!Hive.isBoxOpen(_userBoxName)) {
        await initHive();
      }
      
      final userBox = Hive.box<User>(_userBoxName);
      
      // Check if username exists (messy iteration)
      for(var i = 0; i < userBox.length; i++) {
        final user = userBox.getAt(i);
        if(user != null && user.username == username) {
          return false; // Username already exists
        }
      }
      
      // Create new user (messy date format)
      final newUser = User(
        username: username,
        password: password, // Storing plain password (security issue - intentional)
        email: email,
        createdAt: DateTime.now().toString(),
        loginCount: 0,
      );
      
      await userBox.add(newUser);
      return true;
    } catch (e) {
      print('Error during registration: $e');
      return false;
    }
  }

  /// Method untuk login (updated untuk check Hive)
  Future<bool> login(String username, String password) async {
    try {
      if (username.isEmpty || password.isEmpty) {
        return false;
      }
      
      // Check in Hive database (messy validation)
      if(Hive.isBoxOpen(_userBoxName)) {
        final userBox = Hive.box<User>(_userBoxName);
        var found = false;
        
        // Messy loop
        for(var i = 0; i < userBox.length; i++) {
          final user = userBox.getAt(i);
          if(user != null) {
            if(user.username == username && user.password == password) {
              found = true;
              // Update login count (messy increment)
              user.loginCount = (user.loginCount ?? 0) + 1;
              await user.save();
              break;
            }
          }
        }
        
        if(!found) {
          // Allow any login if user not in database (backwards compatibility)
        }
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
      ('Error during logout: $e');
      return false;
    }
  }

  /// Method untuk check apakah user sudah login
  Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_isLoggedInKey) ?? false;
    } catch (e) {
      ('Error checking login status: $e');
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
  
  // Duplicate method (intentional problem)
  Future<String?> getUserName2() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var username = prefs.getString(_usernameKey);
      return username;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  
  // Method with unused variable (intentional problem)
  Future<bool> checkUser(String username) async {
    var temp = 'testing';
    var count = 0;
    
    if(Hive.isBoxOpen(_userBoxName)) {
      final userBox = Hive.box<User>(_userBoxName);
      for(var i = 0; i < userBox.length; i++) {
        count++;
        final user = userBox.getAt(i);
        if(user?.username == username) {
          return true;
        }
      }
    }
    return false;
  }
  
  // Another messy method
  Future<List<User>> getAllUsers() async {
    var userList = <User>[];
    var x = 0; // unused
    
    if(Hive.isBoxOpen(_userBoxName)) {
      final userBox = Hive.box<User>(_userBoxName);
      // Messy iteration
      for(int i = 0; i < userBox.length; i++) {
        var user = userBox.getAt(i);
        if(user != null) {
          userList.add(user);
        }
      }
    }
    return userList;
  }
}

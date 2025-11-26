import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _usernameKey = 'username';
  static const String _passwordKey = 'password';
  static const String _userBoxName = 'users';

  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  Future<void> initHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    await Hive.openBox<User>(_userBoxName);
  }

  // Method untuk register user baru
  Future<bool> register(String username, String password, String email) async {
    try {
      if (!Hive.isBoxOpen(_userBoxName)) {
        await initHive();
      }

      final userBox = Hive.box<User>(_userBoxName);

      // Check if username exists
      for (var i = 0; i < userBox.length; i++) {
        final user = userBox.getAt(i);
        if (user != null && user.username == username) {
          return false;
        }
      }

      // Create new user
      final newUser = User(
        username: username,
        password: password,
        email: email,
        createdAt: DateTime.now().toString(),
      );

      await userBox.add(newUser);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Method untuk login
  Future<bool> login(String username, String password) async {
    try {
      if (username.isEmpty || password.isEmpty) {
        return false;
      }

      // Check in Hive database
      if (Hive.isBoxOpen(_userBoxName)) {
        final userBox = Hive.box<User>(_userBoxName);

        for (var i = 0; i < userBox.length; i++) {
          final user = userBox.getAt(i);
          if (user != null &&
              user.username == username &&
              user.password == password) {
            await user.save();
            break;
          }
        }
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_usernameKey, username);
      await prefs.setString(_passwordKey, password);

      return true;
    } catch (e) {
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
      return false;
    }
  }

  /// Method untuk check apakah user sudah login
  Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_isLoggedInKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Method untuk get username yang sedang login
  Future<String?> getUsername() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_usernameKey);
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkUser(String username) async {
    if (Hive.isBoxOpen(_userBoxName)) {
      final userBox = Hive.box<User>(_userBoxName);
      for (var i = 0; i < userBox.length; i++) {
        final user = userBox.getAt(i);
        if (user?.username == username) {
          return true;
        }
      }
    }
    return false;
  }

  Future<List<User>> getAllUsers() async {
    var userList = <User>[];

    if (Hive.isBoxOpen(_userBoxName)) {
      final userBox = Hive.box<User>(_userBoxName);
      for (int i = 0; i < userBox.length; i++) {
        var user = userBox.getAt(i);
        if (user != null) {
          userList.add(user);
        }
      }
    }
    return userList;
  }
}

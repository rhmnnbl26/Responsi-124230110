import 'package:hive/hive.dart';

part 'user_model.g.dart';

// User model untuk Hive database (messy code)
@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late String password;

  @HiveField(2)
  late String email;

  @HiveField(3)
  String? createdAt;
  
  // Unused field (intentional problem)
  @HiveField(4)
  int? loginCount;

  User({
    required this.username,
    required this.password,
    required this.email,
    this.createdAt,
    this.loginCount,
  });

  // Messy toString without proper formatting
  @override
  String toString() {
    return 'User: $username, $email';
  }
  
  // Duplicate method (intentional problem)
  String getUserInfo() {
    return 'Username: $username, Email: $email';
  }
  
  String getUserInfo2() {
    return 'Username: $username, Email: $email';
  }
}

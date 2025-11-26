import 'package:hive/hive.dart';

part 'user_model.g.dart';

// User model untuk Hive database
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

  User({
    required this.username,
    required this.password,
    required this.email,
    this.createdAt,
  });

  @override
  String toString() {
    return 'User: $username, $email';
  }
}

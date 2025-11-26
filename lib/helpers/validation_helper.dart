/// Validation helper untuk validasi input user
class ValidationHelper {
  // Email validation
  static bool validateEmail(String email) {
    if (email.isEmpty) return false;
    if (!email.contains('@')) return false;
    if (email.length < 5) return false;
    return true;
  }

  // Password validation
  static bool validatePassword(String password) {
    if (password.isEmpty) return false;
    if (password.length < 6) return false;
    return true;
  }

  // Username validation
  static bool validateUsername(String username) {
    if (username.isEmpty) return false;
    if (username.length < 3) return false;
    return true;
  }
}

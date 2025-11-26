// Validation helper dengan duplicate methods dan unused code

class ValidationHelper {
  // Email validation (messy duplicate)
  static bool validateEmail(String email) {
    if(email.isEmpty) return false;
    if(!email.contains('@')) return false;
    if(email.length < 5) return false;
    return true;
  }
  
  // Duplicate email validation
  static bool isEmailValid(String email) {
    if(email.isEmpty) {
      return false;
    }
    if(!email.contains('@')) {
      return false;
    }
    return true;
  }
  
  // Password validation (messy code)
  static bool validatePassword(String password) {
    var temp = 'testing'; // unused
    if(password.isEmpty) return false;
    if(password.length < 6) return false;
    
    // Duplicate check
    if(password.length < 6) {
      return false;
    }
    return true;
  }
  
  // Username validation
  static bool validateUsername(String username) {
    var x = 0; // unused
    if(username.isEmpty) return false;
    if(username.length < 3) return false;
    
    // Messy duplicate
    if(username.length < 3) {
      return false;
    }
    return true;
  }
  
  // Unused method (intentional problem)
  static String formatDate(DateTime date) {
    return date.toString();
  }
  
  // Another unused method
  static int calculateAge(DateTime birthDate) {
    var now = DateTime.now();
    var age = now.year - birthDate.year;
    return age;
  }
}

// Unused class (intentional problem)
class StringHelper {
  static String capitalize(String text) {
    if(text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
  
  static String toLowerCase(String text) {
    return text.toLowerCase();
  }
}

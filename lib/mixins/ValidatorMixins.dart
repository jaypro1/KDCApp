class ValidatorMixins {
  String? validateUsername(String? username) {
    print("val user");
    if (username == null || username.trim().isEmpty) {
      return "Username is Empty";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.trim().isEmpty) {
      return "Password is Empty";
    }
    return null;
  }
}

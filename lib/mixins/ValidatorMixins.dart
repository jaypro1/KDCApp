class ValidatorMixins {
  final RegExp emailRegEx = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  String? validateEmail(String? email) {
    print("validate email");
    if (email == null || email.trim().isEmpty) {
      return "email is Empty";
    }

    if (!emailRegEx.hasMatch(email)) {
      return "Invalid Email Id";
    }
    return null;
  }

  String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return "Name cannot be Empty";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.trim().isEmpty) {
      return "Password is Empty";
    }
    return null;
  }

  String? validateCodeMessage(String? code) {
    if (code == null || code.trim().isEmpty) {
      return "Code is Empty";
    }
    if (code.trim().length != 6) {
      return "Phone Number should be 10 Digits";
    }
    return null;
  }

  String? validatePhoneNumber(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return "Phone Number is Empty";
    }
    if (phone.trim().replaceAll("-", "").length != 10) {
      return "Phone Number should be 10 Digits";
    }
    return null;
  }
}

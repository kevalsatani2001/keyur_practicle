class Validators {
  static String? validateEmail(
      String? value,
      String emptyError,
      String invalidError,
      ) {
    if (value == null || value.trim().isEmpty) {
      return emptyError;
    }

    // ✅ Improved regex (supports +, ., -, _ before @)
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$",
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return invalidError;
    }
    return null;
  }

  static String? validateName(String? value, String emptyMsg) {
    if (value == null || value.trim().isEmpty) {
      return emptyMsg;
    }
    return null;
  }

  static String? validateMobile(String? value, String emptyMsg, String invalidMsg) {
    if (value == null || value.isEmpty) {
      return emptyMsg;
    }
    if (value.length < 10) {
      return invalidMsg;
    }
    return null;
  }

  static String? validatePassword(String? value, String emptyMsg, String shortMsg) {
    if (value == null || value.isEmpty) {
      return emptyMsg;
    }
    if (value.length < 6) {
      return shortMsg;
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? value, String password, String emptyMsg, String mismatchMsg) {
    if (value == null || value.isEmpty) {
      return emptyMsg;
    }
    if (value != password) {
      return mismatchMsg;
    }
    return null;
  }
}

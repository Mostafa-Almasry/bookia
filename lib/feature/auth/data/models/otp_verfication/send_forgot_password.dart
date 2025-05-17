class SendForgetPassword {
  final String email;

  SendForgetPassword({required this.email});

  Map<String, dynamic> toJson() {
    return {"email": email};
  }
}

class CheckForgetPasswordCode {
  final String email;
  final String verifyCode;

  CheckForgetPasswordCode({required this.verifyCode, required this.email});

  Map<String, dynamic> toJson() {
    return {"email": email, "verify_code": verifyCode};
  }
}

class ResetPassword {
  final String newPassword;
  final String newPasswordConfirmation;
  final String verifyCode;

  ResetPassword({
    required this.verifyCode,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      "verify_code": verifyCode,
      "new_password": newPassword,
      "new_password_confirmation": newPasswordConfirmation,
    };
  }
}
